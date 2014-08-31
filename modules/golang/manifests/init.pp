class golang(
  $version = '1.3.1',
  $gopath = '/root/go'
) {

  # install SVN, Mercurial, Git
  # install packages?

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
  ->

  helper::script {'install golang':
    content => template('golang/install.sh'),
    unless => "test -x /usr/bin/go && /usr/bin/go version | grep 'go${version}'",
  }

}
