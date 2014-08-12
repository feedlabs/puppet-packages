class gopush (
  $version = '1.0-commit'
) {

  user {'gopush':
    ensure => present,
    system => true,
  }

  file {
    '/etc/gopush':
      ensure  => directory,
      mode    => '0644',
      owner   => 'gopush',
      group   => 'gopush';

    '/var/run/gopush':
      ensure  => directory,
      mode    => '0644',
      owner   => 'gopush',
      group   => 'gopush';
  }
  ->

  helper::script {'install gopush-cluster':
    content => template('gopush/install.sh'),
    unless => "test -x /usr/bin/gpcomet && /usr/bin/gpcomet -v | grep 'go${version}'",
  }

}
