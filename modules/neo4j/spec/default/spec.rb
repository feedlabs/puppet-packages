require 'spec_helper'

describe user('neo4j') do
  it { should exist }
  it { should belong_to_group 'neo4j' }
end

describe package('openjdk-7-jre') do
  it { should be_installed.by('apt') }
end

describe service('neo4j-service') do
  it { should be_enabled }
  it { should be_running }
end

describe port(7474) do
  it { should be_listening }
end
