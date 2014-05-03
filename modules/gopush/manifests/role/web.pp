class gopush::role::web (
  $port = 8080
) {

  gopush::core::webd {'web':
    port => $port,
  }

}
