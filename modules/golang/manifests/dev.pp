define golang::dev (
  $go_path
) {

  file {"create gopath dir for ${name}":
    path => $go_path,
    ensure => directory,
    mode => 0644,
    owner => 0,
    group => 0,
  }
  ->

  file {"create golang profile for ${name}":
    path => "/etc/profile.d/golang-${name}.sh",
    ensure => file,
    content => template('golang/profile'),
    mode => 0644,
    owner => 0,
    group => 0,
  }

}
