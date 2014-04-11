class nsq::server (
  $version = '0.2.27',
  $http_address = '0.0.0.0',
  $http_port    = '14151',
  $tcp_address  = '0.0.0.0',
  $tcp_port     = '14150'
) {

  require 'nsq'

  file {
    '/etc/nsq/nsqd.conf':
      ensure => file,
      content => template('nsq/nsqd/conf'),
      mode => 644,
      owner => 'nsq';

    '/etc/init.d/nsqd':
      ensure => file,
      content => template('nsq/nsqd/init'),
      mode => 755,
      owner => 'nsq';
  }

  service {'nsqd': }

  @monit::entry {'nsqd':
    content => template('nsq/nsqd/monit'),
    require => Service['nsqd'],
  }

}
