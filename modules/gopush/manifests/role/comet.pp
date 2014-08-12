class gopush::role::comet (
  $port_ws = 6968,
  $port_tcp = 6969,
  $port_rpc = 6970
) {

  gopush::core::cometd {'comet':
    port_ws => $port_ws,
    port_tcp => $port_tcp,
    port_rpc => $port_rpc,
  }

}
