class cayley::service {

  require 'cayley'

  service {'cayleyd':
    hasrestart => true,
  }
}
