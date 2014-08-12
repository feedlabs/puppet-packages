#!/bin/sh -e

curl -sL https://go.googlecode.com/files/go<%= @version %>.linux-amd64.tar.gz > go.tar.gz
tar -xvf go.tar.gz
cp -R go /usr/local/

if [ -f /usr/bin/go ] ; then
  rm /usr/bin/go
fi

ln -s /usr/local/go/bin/go /usr/bin/go

echo 'export GOROOT=/usr/local/go' >> /etc/golang
echo 'export GOPATH=<%= @gopath %>' >> /etc/golang
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/golang
