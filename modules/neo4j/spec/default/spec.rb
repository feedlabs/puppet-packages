require 'spec_helper'

describe port(7474) do
  it { should be_listening }
end
