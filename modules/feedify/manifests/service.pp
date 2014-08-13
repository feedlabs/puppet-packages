class feedify::service {

  require 'feedify'

  service {'feedify':
    hasrestart => true,
  }
}
