class cayley::backend::leveldb ($db_path) {

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
