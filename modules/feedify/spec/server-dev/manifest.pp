node default {

  class {'feedify::server-dev':
    source => '/vagrant/modules/feedify/files/test',
    main_script => 'index.go',
    install_script => 'install.sh',
  }

}
