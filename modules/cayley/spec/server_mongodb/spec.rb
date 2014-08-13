require 'spec_helper'

describe port(64210) do
  it { should be_listening.with('tcp6') }
end

describe port(27017) do
  it { should be_listening.with('tcp') }
end

describe user('cayley') do
  it { should exist }
  it { should belong_to_group 'cayley' }
end

describe service('cayleyd') do
  it { should be_enabled }
  it { should be_running }
  it { should be_monitored_by('monit') }
end

describe command('curl -XPOST -d \'[{"subject":"subject","predicate":"predicate","object":"object"}]\' localhost:64210/api/v1/write') do
  its(:stdout) { should match /Successfully wrote 1 triples/ }
end

describe command('curl -XPOST -d "graph.Vertex().All()" localhost:64210/api/v1/query/gremlin') do
  its(:stdout) { should match /"id": "subject"/ }
  its(:stdout) { should match /"id": "predicate"/ }
  its(:stdout) { should match /"id": "object"/ }
end

describe command("mongo cayley --quiet --eval 'printjson(db.getCollectionNames())'") do
  its(:stdout) { should match /system.indexes/ }
end
