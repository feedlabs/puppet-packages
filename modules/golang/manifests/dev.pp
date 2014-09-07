define golang::dev (
  $gopath = $name
) {

  file {$gopath:
    ensure => directory,
    mode => 0644,
    owner => 0,
    group => 0,
  }
  ->

  file {'/etc/profile.d/golang.sh':
    ensure => file,
    content => template('golang/profile'),
    mode => 0644,
    owner => 0,
    group => 0,
  }

}
