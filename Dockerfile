FROM golang:1.15 AS builder

RUN git clone https://github.com/coredns/coredns /coredns

WORKDIR /coredns

RUN \
    echo "git:github.com/miekg/coredns-git" >> plugin.cfg && \
    echo "alternate:github.com/coredns/alternate" >> plugin.cfg && \
    echo "records:github.com/coredns/records" >> plugin.cfg 

RUN make