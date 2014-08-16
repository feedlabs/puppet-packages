class feedify {

  user {'feedify':
    ensure => present,
    system => true,
    home => '/home/feedify'
  }
  ->

  file {['/home/feedify', '/etc/feedify']:
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }

}
