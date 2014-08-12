class cayley::backend::leveldb (
  $db_path,
  $write_buffer_mb = 20,
  $cache_size_mb = 2
) {

  file {$db_path:
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ~>

  exec {'init leveldb storage':
    provider => shell,
    command => 'cayley init -config /etc/cayley/cayley.cfg',
    refreshonly => true,
  }

}
