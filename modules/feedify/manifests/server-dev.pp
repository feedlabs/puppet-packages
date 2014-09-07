define feedify::server-dev (
  $source,
  $port = 8080,
  $go_script = 'main.go',
  $go_path = '/home/feedify/go',
  $install_script = 'install.sh'
) {

  require 'feedify'

  $daemon_args = "--config /etc/feedify/feedify-${name}.conf --port ${port}"

  feedify::dev {$name:
    go_path => $go_path,
    install_script => $install_script,
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

  feedify::service {$name: }

  @monit::entry {"feedify-${name}":
    content => template('feedify/monit'),
    require => Service["feedify-${name}"],
  }

}
