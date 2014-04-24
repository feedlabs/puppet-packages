class neo4j::install (
  $binary,
  $install_dir,
  $dirname,
) {

  file {"${install_dir}":
    ensure => directory,
  }

  exec {'extract archive':
    command => "tar -xzvf ${binary}",
    cwd     => $install_dir,
    path    => '/bin',
    creates => "${install_dir}/${dirname}",
  }

  exec {'neo4j install':
    command => "${install_dir}/${dirname}/bin/neo4j install -u neo4j -h",
    creates => '/etc/init.d/neo4j-service',
  }

  package {'openjdk-7-jre':
    ensure => installed,
  }

  package {'lsof':
    ensure => installed,
  }

}
