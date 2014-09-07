class feedify::service ($name) {

  include 'feedify'

  exec {"update-rc.d feedify-${name} defaults && /etc/init.d/feedify-${name} start":
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    subscribe => File["/etc/init.d/feedify-${name}"],
    require => Service["feedify-${name}"],
  }

  service {"feedify-${name}":
    hasrestart => true,
  }
}
