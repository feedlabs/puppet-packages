class golang(
  $version = '1.2',
  $gopath = '/root/go'
) {

  file {$gopath:
    ensure => directory,
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


