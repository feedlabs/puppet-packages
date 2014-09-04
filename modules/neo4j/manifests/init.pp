class neo4j (
  $port = 7474
){

  require 'java7'
  require 'neo4j::apt'
  include 'neo4j::service'

  user {'neo4j':
    ensure => present,
    system => true,
  }
  ->

  file {
    '/etc/neo4j':
      ensure => directory,
      owner => 'neo4j',
      group => '0',
      mode => '0644';

    '/etc/neo4j/neo4j.properties':
      ensure => file,
      content => template('neo4j/neo4j'),
      owner => 'neo4j',
      group => '0',
      mode => '0644',
      notify => Service['neo4j-service'];

    '/etc/neo4j/neo4j-server.properties':
      ensure => file,
      content => template('neo4j/neo4j-server'),
      owner => 'neo4j',
      group => '0',
      mode => '0644',
      notify => Service['neo4j-service'];

    '/etc/neo4j/neo4j-wrapper.properties':
      ensure => file,
      content => template('neo4j/neo4j-wrapper'),
      owner => 'neo4j',
      group => '0',
      mode => '0644',
      notify => Service['neo4j-service'];
  }
  ->

  package {'neo4j':
    ensure => present,
  }

  @monit::entry {'neo4j-service':
    content => template('neo4j/monit'),
    require => Service['neo4j-service'],
  }

}
