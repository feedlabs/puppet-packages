require 'spec_helper'

describe file('/etc/neo4j/neo4j-server.properties') do
  it { should be_file }
end

describe port(7474) do
  it { should be_listening }
end
