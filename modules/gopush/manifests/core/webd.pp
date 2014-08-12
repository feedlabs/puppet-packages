define gopush::core::webd (
  $port = 8080,
  $bind_ip = undef
) {

  require 'gopush'

  $daemon = 'gpweb'
  $instance_name = "${daemon}_${name}"

  file {
    "/etc/gopush/${instance_name}.conf":
      ensure  => file,
      content => template('gopush/webd/conf'),
      mode    => '0644',
      owner   => 'gopush',
      group   => 'gopush',
      notify  => Service[$instance_name];
  }
  ->

  gopush::core::service {$instance_name: }

}
