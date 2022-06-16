ARG GO_VERSION=1.17
ARG COREDNS_VERSION=v1.8.6

FROM golang:${GO_VERSION}

# clone coredns repo
RUN git clone https://github.com/coredns/coredns /coredns
WORKDIR /coredns

RUN \
    # checkout the desired coredns version
    git checkout ${COREDNS_VER} && \
    # add coredns plugins
    echo "git:github.com/miekg/coredns-git" >> plugin.cfg && \
    echo "alternate:github.com/coredns/alternate" >> plugin.cfg && \
    echo "records:github.com/coredns/records" >> plugin.cfg && \
    # run make to build binary
    make