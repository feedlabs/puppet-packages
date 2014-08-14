require 'spec_helper'

describe file('/usr/bin/go') do
  it { should be_file }
  it { should be_linked_to '/usr/local/go/bin/go' }
end

describe command('go version') do
  its(:stdout) { should match /go1.2/ }
end

describe file('/etc/profile.d/golang.sh') do
  its(:content) { should match /export GOPATH=\/root\/go/ }
  its(:content) { should match /export GOROOT=\/usr\/local\/go/ }
end
