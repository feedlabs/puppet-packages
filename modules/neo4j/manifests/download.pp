class neo4j::download (
  $edition,
  $version,
  $filename,
) {

  exec {'neo4j download':
    command => "wget http://dist.neo4j.org/${filename} -O /tmp/${filename}",
    path    => '/usr/bin',
    require => Package['wget'],
    creates => "/tmp/${filename}",
  }

  package {'wget':
    ensure => installed,
  }

}
