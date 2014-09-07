define feedify::dev (
	$go_path,
  $install_script
) {

  require 'golang'

  golang::dev {$name:
    go_path => $go_path,
    require => User['feedify'],
  }
  ->

  helper::script {"install ${name}":
    content => template('feedify/setup.sh'),
    unless => " ! test -e ${install_script} ",
  }

}
