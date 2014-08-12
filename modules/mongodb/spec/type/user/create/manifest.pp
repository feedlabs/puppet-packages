node default {

  class {'mongodb::role::standalone':
    port => 27017,
  }
  ->

  mongodb_database {'testdb':
    ensure => present,
  }
  ->

  mongodb_user {'testuser':
    database => 'testdb',
    password => 'my-password2',
    roles => [ {"role" => "dbAdmin", "db"=> "testdb"} ],
  }

}
