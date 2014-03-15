class neo4j {

  exec {
    'neotech signing key':
      command => '/usr/bin/wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -',
      before  => Exec['apt-get update'],
      unless  => '/usr/bin/apt-key list | grep -q neotechnology.com';
  }
  ->

  file {
    'neo4j contrib dir':
      ensure => directory,
      path   => '/usr/share/neo4j-contrib';
  }
  ->

  file {
    'neo4j apt config':
      path    => '/etc/apt/sources.list.d/neo4j.list',
      content => 'deb http://debian.neo4j.org/repo stable/',
  }
  ->

  exec {
    'apt-get update':
      command => '/usr/bin/apt-get update';
  }
  ->

  package {
    'neo4j':
      ensure  => present,
  }
  ->

#  file {
#    'neo4j auth extension':
#      path    => '/usr/share/neo4j-contrib/authentication-extension-1.8.1-fudge.jar',
#      source  => 'puppet:///modules/neo4j/authentication-extension-1.8.1-fudge.jar',
#  }
#  ->
#
#  file {
#    'neo4j auth extension link':
#      ensure  => 'link',
#      path    =>  '/usr/share/neo4j/plugins/authentication-extension-1.8.1-fudge.jar',
#      target  => '/usr/share/neo4j-contrib/authentication-extension-1.8.1-fudge.jar',
#  }
#  ->

#  file {
#    'neo4j config file':
#      path     => '/etc/neo4j/neo4j-server.properties',
#      content  => template('neo4j/neo4j-server.properties.erb'),
#      owner    => neo4j,
#      group    => adm;
#  }
#  ->

  service {
    'neo4j-service':
      ensure  => running,
      enable  => true,
  }
  ->

  exec {
    'restart neo4j':
      command     => '/usr/sbin/service neo4j-service restart';

#    'bump the minimum heap size':
#      command     => '/bin/echo "wrapper.java.initmemory=1024" >> /etc/neo4j/neo4j-wrapper.conf',
#      require     => Package['neo4j'],
#      unless      => '/bin/grep "^wrapper.java.initmemory" /etc/neo4j/neo4j-wrapper.conf 2>/dev/null';
#
#    'bump the maximum heap size':
#      command     => '/bin/echo "wrapper.java.maxmemory=4096" >> /etc/neo4j/neo4j-wrapper.conf',
#      require     => Package['neo4j'],
#      unless      => '/bin/grep "^wrapper.java.maxmemory" /etc/neo4j/neo4j-wrapper.conf 2>/dev/null';
  }

  @monit::entry {'neo4j':
    content => template('neo4j/monit/neo4j'),
  }

}
