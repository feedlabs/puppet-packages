#!/bin/sh -e

curl -sL https://github.com/google/cayley/releases/download/v<%= @version %>/cayley_<%= @version %>_linux_amd64.tar.gz > cayley.tar.gz
tar -xvf cayley.tar.gz
cd cayley_*

chown -R cayley:cayley *

rm -rf /usr/lib/cayley/
mkdir -p /usr/lib/cayley

cp cayley /usr/bin/cayley
mv * /usr/lib/cayley/

