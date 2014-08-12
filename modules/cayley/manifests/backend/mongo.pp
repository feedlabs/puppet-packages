class cayley::backend::mongo (
  $db_path,
  $database_name = 'cayley'
) {

  $init_file = "/etc/cayley/inits/${db_path}.${database_name}"

  file {$init_file:
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ~>

  exec {'init mongodb storage':
    provider => shell,
    command => 'cayley init -config /etc/cayley/cayley.cfg',
    onlyif => "! test -x ${init_file}",
    refreshonly => true,
  }
}
