class cayley::server (
  $port = 643636,
  $bind_ip = '0.0.0.0',
  $backend = 'leveldb',
  $backend_options = {}
) {

  include 'cayley::service'


}
