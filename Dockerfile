FROM golang:alpine AS COREDNS
RUN apk add git make
RUN git clone https://github.com/coredns/coredns.git && \
    echo fanout:github.com/networkservicemesh/fanout >> coredns/plugin.cfg && \
    cd coredns && \
    make
FROM hashicorp/consul-template:0.25.2-scratch as CONSUL_TEMPLATE
FROM consul as CONSUL
COPY --from=COREDNS /go/coredns/coredns /usr/bin/coredns
COPY --from=CONSUL_TEMPLATE /consul-template /bin/consul-template
COPY entrypoint.sh /entrypoint.sh
COPY Corefile.tpl /coredns/Corefile.tpl
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
