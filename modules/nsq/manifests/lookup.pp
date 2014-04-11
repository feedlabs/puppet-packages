class nsq::lookup (
  $version = '0.2.27',
  $http_address = '0.0.0.0',
  $http_port    = '14161',
  $tcp_address  = '0.0.0.0',
  $tcp_port     = '14160'
) {

  include 'nsq'

  file {'/etc/nsq/nsqlookupd.conf':
    ensure => file,
    content => template('nsq/nsqlookupd/conf'),
    mode => 644,
    owner => 'nsq',
  }

  file {'/etc/init.d/nsqlooupd':
    ensure => file,
    content => template('nsq/nsqlookupd/init'),
    mode => 755,
    owner => '0',
    group => '0',
    notify => Service['nsqlookupd'],
  }
  ~>

  exec {'update-rc.d nsqlookupd defaults  && /etc/init.d/nsqlookupd start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  service {'nsqlookupd': }

  @monit::entry {'nsqlookupd':
    content => template('nsq/nsqlookupd/monit'),
    require => Service['nsqlookupd'],
  }

}
