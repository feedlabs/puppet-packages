node default {

  class {'cayley::server':
    database => 'leveldb',
    database_path => '/tmp/leveldb'
  }
}
