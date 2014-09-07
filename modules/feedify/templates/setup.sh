#!/bin/sh -e

# golang environement
export GOPATH=<%= @go_path %>
echo 'export PATH=$PATH:<%= @go_path %>/bin' > /etc/profile.d/feedify.sh

# install beego framework and tool
go get github.com/beego/bee
go get github.com/astaxie/beego

# development dependencies install
chmod +x <%= @install_script %>
. <%= @install_script %> $GOPATH <%= @source %>

# link bee tool to global path
if [ -e /usr/bin/bee ]; then
  rm /usr/bin/bee
fi

ln -s $GOPATH/bin/bee /usr/bin/bee
