require 'spec_helper'

describe command('php --ri curl') do
  it { should return_exit_status 0 }
end

describe file('/var/log/php/error.log') do
  its(:content) { should_not match /Warning.*curl.*already loaded/ }
end
