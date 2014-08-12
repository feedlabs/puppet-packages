node default {

  class {'mongodb::role::standalone':
    bind_ip => 'localhost',
    port => 27017,
  }
  ->

  class {'cayley::server':
    database => 'mongodb',
    database_path => 'localhost:27017',
    database_options => {
      database_name => 'cayley'
    }
  }
}
