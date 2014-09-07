define feedify::server-dev (
  $source,
  $port = 8080,
  $go_script = 'main.go',
  $go_path = '/home/feedify/go',
  $install_script = 'install.sh'
) {

  require 'feedify'

  $daemon_args = "--config /etc/feedify/feedify-${name}.conf --port ${port}"

  class {'feedify::service':
    name => $name,
  }

  class {'golang':
    version => '1.3.1',
    gopath => $go_path,
    require => User['feedify'],
  }
  ->

  helper::script {'install and setup feedify environment':
    content => template('feedify/setup.sh'),
    unless => " ! test -e ${install_script} ",
  }
  ->

  file {"/etc/feedify/feedify-${name}.conf":
    ensure => file,
    content => template('feedify/conf'),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service["feedify-${name}"],
  }
  ->

  file {"/etc/init.d/feedify-${name}":
    ensure => file,
    content => template('feedify/init-dev'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service["feedify-${name}"],
  }

  @monit::entry {"feedify-${name}":
    content => template('feedify/monit'),
    require => Service["feedify-${name}"],
  }

}
