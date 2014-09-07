define feedify::dev (
	$go_path,
  $install_script
) {

  class {'golang':
    version => '1.3.1',
    gopath => $go_path,
    require => User['feedify'],
  }
  ->

  helper::script {'install and setup feedify environment':
    content => template('feedify/setup.sh'),
    unless => " ! test -e ${install_script} ",
  }
}
