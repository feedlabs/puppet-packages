class golang(
  $version = '1.3.1'
) {

  # install SVN, Mercurial, Git
  # install packages?

  helper::script {'install golang':
    content => template('golang/install.sh'),
    unless => "test -x /usr/bin/go && /usr/bin/go version | grep 'go${version}'",
  }

}
