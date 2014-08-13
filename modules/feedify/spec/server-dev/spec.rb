require 'spec_helper'

describe user('feedify') do
  it { should exist }
  it { should belong_to_group 'feedify' }
end

describe port(8080) do
  it { should be_listening }
end
