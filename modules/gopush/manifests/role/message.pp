class gopush::role::message (
  $port = 8170
) {

  gopush::core::msgd {'message':
    port => $port,
  }

}
