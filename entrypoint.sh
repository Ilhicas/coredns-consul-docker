#!/bin/sh
# Set coredns in background
consul-template -once -template "/coredns/Corefile.tpl:/coredns/Corefile"
echo "Setting up coredns, definition bellow"
cat /coredns/Corefile
coredns -conf /coredns/Corefile -quiet &
consul agent -data-dir=/var/consul -node=client-1 -retry-join=172.17.0.1
