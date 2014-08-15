require 'spec_helper'

describe user('feedify') do
  it { should exist }
  it { should belong_to_group 'feedify' }
end

describe command('bee version') do
  its(:stdout) { should match /bee.*/ }
  its(:stdout) { should match /beego.*/ }
  its(:stdout) { should match /Go.*1.2/ }
end

describe service('feedify') do
  it { should be_enabled }
  it { should be_running }
end

describe port(10100) do
  it { should be_listening }
end
