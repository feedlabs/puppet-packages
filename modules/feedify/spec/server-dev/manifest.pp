node default {

  $source_path = '/vagrant/modules/feedify/files/test'

  class {'feedify::server-dev':
    source => $source_path,
    go_script => "${source_path}/index.go",
    install_script => "${source_path}/install.sh",
  }

}
