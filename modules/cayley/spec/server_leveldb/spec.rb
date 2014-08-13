require 'spec_helper'

describe port(64210) do
  it { should be_listening.with('tcp6') }
end

describe file('/tmp/leveldb') do
  it { should be_directory }
end

describe user('cayley') do
  it { should exist }
  it { should belong_to_group 'cayley' }
end

describe service('cayleyd') do
  it { should be_enabled }
  it { should be_running }
end

