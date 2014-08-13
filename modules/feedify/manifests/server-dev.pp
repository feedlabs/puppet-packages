class feedify::server-dev (
  $source,
  $main_script = 'main.go',
  $install_script = 'install-dev.sh',
  $port = '8080'
) {

  include 'feedify::service'

  $gopath = '/home/feedify/go'
  $daemon_args = "run ${source}/${main_script}"

  class {'golang':
    version => '1.2',
    gopath => $gopath,
    require => User['feedify'],
  }
  ->

  helper::script {'install cayley':
    content => template('feedify/setup.sh'),
    unless => " ! test -e ${source}/${install_script} "
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
