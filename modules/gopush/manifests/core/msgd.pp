define gopush::core::msgd (
  $port = 8170,
  $bind_ip = undef
) {

  require 'gopush'

  $daemon = 'gpmsg'
  $instance_name = "${daemon}_${name}"

  file {
    "/etc/gopush/${instance_name}.conf":
      ensure  => file,
      content => template('gopush/msgd/conf'),
      mode    => '0644',
      owner   => 'gopush',
      group   => 'gopush',
      notify  => Service[$instance_name];
  }
  ->

  gopush::core::service {$instance_name: }

}
