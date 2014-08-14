class feedify::server-dev (
  $source,
  $go_script = 'main.go',
  $go_path = '/home/feedify/go',
  $install_script = 'install.sh',
  $daemon_args = '',
  $port = '8080'
) {

  include 'feedify::service'

  class {'golang':
    version => '1.2',
    gopath => $go_path,
    require => User['feedify'],
  }
  ->

  helper::script {'install and setup feedify environment':
    content => template('feedify/setup.sh'),
    unless => " ! test -e ${install_script} "
  }
  ->

  file {'/etc/init.d/feedify':
    ensure => file,
    content => template('feedify/init-dev'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['feedify'],
  }
  ~>

  exec {'update-rc.d feedify defaults && /etc/init.d/feedify start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  @monit::entry {'feedify':
    content => template('feedify/monit'),
    require => Service['feedify'],
  }

}
