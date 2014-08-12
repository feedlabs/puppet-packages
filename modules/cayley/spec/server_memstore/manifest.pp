node default {

  class {'cayley::server':
    database => 'memstore',
    database_path => '/tmp/memorydb'
  }
}
