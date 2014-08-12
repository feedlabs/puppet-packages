class cayley::backend::leveldb (
  $db_path,
  $write_buffer_mb = 20,
  $cache_size_mb = 2
) {

  file {$db_path:
    ensure => directory,
    owner => 'cayley',
    group => 'cayley',
    mode => '0644',
  }
  ~>

  exec {'init leveldb storage':
    provider => shell,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command => 'cayley init -config /etc/cayley/cayley.cfg',
    refreshonly => true,
    user => 'cayley',
    require => [ Class['cayley'], File['/etc/cayley/cayley.cfg'] ],
  }

}
