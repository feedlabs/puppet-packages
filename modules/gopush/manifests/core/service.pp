define gopush::core::service {

  file {
    "/etc/init.d/${name}":
    ensure  => file,
    content => template('gopush/init'),
    mode    => '0755',
    owner   => 'gopush',
    group   => 'gopush',
    notify  => Service[$name];
  }
  ->

  helper::service {$name: }

  @monit::entry {$name:
    content => template('gopush/monit'),
    require => Service[$name],
  }

}
