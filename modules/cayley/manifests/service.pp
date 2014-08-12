class cayley::service {

  require 'cayley'

  service {'cayley':
    hasrestart => true,
  }

  @monit::entry {'cayley':
    content => template('cayley/monit'),
    require => Service['cayley'],
  }
}
