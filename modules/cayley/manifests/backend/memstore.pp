class cayley::backend::memstore (
  $db_path
){

  file {$db_path:
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
  }

}
