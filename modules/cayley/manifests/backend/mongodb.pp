class cayley::backend::mongodb (
  $db_path
) {

  exec {'init mongodb storage':
    provider => shell,
    command => 'cayley init -config /etc/cayley/cayley.cfg',
    refreshonly => true,
  }
}
