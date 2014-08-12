class cayley(
  $version = '0.3.1'
){

  user {'cayley':
    ensure => present,
    system => true,
  }
  ->

  file {'/etc/cayley':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  file {'/etc/cayley/inits':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  file {'/usr/lib/cayley':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  file {'/var/log/cayley':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  helper::script {'install cayley':
    content => template('cayley/install.sh'),
    unless => "test -x /usr/bin/cayley && /usr/bin/cayley version | grep 'Cayley ${version}'"
  }
}
