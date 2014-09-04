require 'spec_helper'

describe user('neo4j') do
  it { should exist }
  it { should belong_to_group 'neo4j' }
end

describe service('neo4j-service') do
  it { should be_enabled }
  it { should be_running }
  it { should be_monitored_by('monit') }
end

describe port(7474) do
  it { should be_listening }
end
