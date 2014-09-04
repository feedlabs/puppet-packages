class neo4j::service {

  service {'neo4j-service':
    ensure => running,
  }
}
