#!/bin/sh -e

curl -sL https://go.googlecode.com/files/go<%= @version %>.linux-amd64.tar.gz > go.tar.gz
tar -xvf go.tar.gz
cp -R go /usr/local/

if [ -f /usr/bin/go ] ; then
  rm /usr/bin/go
fi

ln -s /usr/local/go/bin/go /usr/bin/go

