require 'spec_helper'

describe command('cayley version') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /Cayley 0.3.1/ }
end
