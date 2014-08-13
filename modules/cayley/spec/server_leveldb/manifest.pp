node default {

  class {'cayley::server':
    database => 'leveldb',
    database_path => '/tmp/leveldb',
    database_options => {
      write_buffer_mb => 20,
      cache_size_mb => 2
    }
  }
}
