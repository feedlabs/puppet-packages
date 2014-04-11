class java7 {

  apt::source {'webupd8team':
    entries => [
      'deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main',
      'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main'
    ],
    keys => {
      'mongodb' => {
        'key' => 'EEA14886',
        'key_server' => 'keyserver.ubuntu.com',
      }
    },
  }

  package { 'oracle-java7-installer':
    responsefile => '/tmp/java.preseed',
    require      => [ Apt::Source['webupd8team'], File['/tmp/java.preseed'] ],
  }

  file { '/tmp/java.preseed':
    source => 'puppet:///modules/java7/java.preseed',
    mode   => '0600',
    backup => false,
  }

}
