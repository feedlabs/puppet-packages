class cayley::server (
  $port = 64210,
  $bind_ip = '0.0.0.0',
  $database = 'leveldb',
  $database_path = '/tmp/testdb',
  $database_options = {},
  $read_only = false,
  $load_size = 10000,
  $timeout = 30
) {

  include 'cayley::service'

  $daemon_args = "http -config=/etc/cayley/cayley.cfg -assets=/usr/lib/cayley -v=1 -log_dir=/var/log/cayley"

  $configuration = {
    database    => $database,
    db_path     => $database_path,
    listen_host => $bind_ip,
    listen_port => $port,
    load_size   => $load_size,
    timeout     => $timeout,
    db_options  => $database_options
  }

  case $database {
    ['mongodb', 'leveldb']: {
      $defaults = {
        db_path => $database_path
      }
    }

    default: {
      fail("Not supported backend database ${database}")
    }
  }

  $arguments = { "Cayley::Backend::${database}" => $database_options }
  create_resources('class', $arguments, $defaults)

  file {"/etc/cayley/cayley.cfg":
    ensure => file,
    content => template('cayley/conf'),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['cayleyd'],
  }
  ->

  file {'/etc/init.d/cayleyd':
    ensure => file,
    content => template('cayley/init'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['cayleyd'],
  }
  ~>

  exec {'update-rc.d cayleyd defaults && /etc/init.d/cayleyd start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  @monit::entry {'cayley':
    content => template('cayley/monit'),
    require => Service['cayleyd'],
  }
}
