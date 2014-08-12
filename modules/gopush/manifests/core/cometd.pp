define gopush::core::cometd (
  $port_ws = 6968,
  $port_tcp = 6969,
  $port_rpc = 6970,
  $bind_ip = undef,
  $zoo_comet_path = '/gopush-cluster-comet',
  $zoo_msg_path = '/gopush-cluster-message',
  $zoo_host = 'localhost:2181'
) {

  require 'gopush'

  $daemon = 'gpcomet'
  $instance_name = "${daemon}_${name}"

  file {
    "/etc/gopush/${instance_name}.conf":
      ensure  => file,
      content => template('gopush/cometd/conf'),
      mode    => '0644',
      owner   => 'gopush',
      group   => 'gopush',
      notify  => Service[$instance_name];
  }
  ->

  gopush::core::service {$instance_name: }

}
