require 'spec_helper'

describe command('sleep 15') do
  it { should return_exit_status 0 }
end
