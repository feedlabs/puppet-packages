#!/bin/sh -e

# golang environement
export GOPATH=<%= @gopath %>
echo 'export PATH=$PATH:<%= @gopath %>/bin' > /etc/profile.d/feedify.sh

# install beego framework and tool
go get github.com/beego/bee
go get github.com/astaxie/beego

# development dependencies install
chmod +x <%= @source %>/<%= @install_script %>
. <%= @source %>/<%= @install_script %>

# link bee tool to global path
if [ -e /usr/bin/bee ]; then
  rm /usr/bin/bee
fi

ln -s <%= @gopath %>/bin/bee /usr/bin/bee
