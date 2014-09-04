class neo4j::apt {

  apt::source {'neo4j':
    entries => [ "deb http://debian.neo4j.org/repo stable/" ],
    keys => {
      'neo4j' => {
        key     => '2DC499C3',
        key_url => 'http://debian.neo4j.org/neotechnology.gpg.key',
      }
    }
  }
}
