node default {

  class {'feedify::server-dev':
    repo => '/vagrant/feedify'
  }
}
