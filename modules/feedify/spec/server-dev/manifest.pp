node default {

  $source_path = '/vagrant/modules/feedify/files/test'

  feedify::server-dev {'test':
    source => $source_path,
    go_script => "${source_path}/index.go",
    install_script => "${source_path}/install.sh",
    port => 10100,
  }

}
