#!/bin/sh -e

export GOPATH=<%= @gopath %>
chmod +x <%= @source %>/<%= @install_script %>
. <%= @source %>/<%= @install_script %>

echo 'export PATH=$PATH:<%= @gopath %>/bin' > /etc/profile.d/feedify.sh

