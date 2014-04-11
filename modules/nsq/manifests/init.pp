class nsq (
  $version = '0.2.27',
  $config_dir   = '/etc/nsq',
  $data_dir     = '/var/lib/nsq',
  $log_dir      = '/var/log/nsq',
  $bin_dir      = '/usr/bin',
  $template_dir = '/usr/local/share/nsqadmin/templates'
) {

  user {'nsq':
    ensure => present,
    system => true,
  }

  helper::script {'install nsq':
    content => template('nsq/install.sh'),
    unless => "test -x /usr/bin/nsqd && /usr/bin/nsqd -version | grep '^v${version}$'",
    require => User['nsq'],
    timeout => 900,
  }

}
