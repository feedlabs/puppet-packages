class cayley(
  $version = '0.3.1'
){

  user {'cayley':
    ensure => present,
    system => true,
  }
  ->

  helper::script {'install cayley':
    content => template('cayley/install.sh'),
    unless => "test -x /usr/bin/cayley && /usr/bin/cayley version | grep 'Cayley ${version}'"
  }
}
