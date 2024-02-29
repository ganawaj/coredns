FROM golang:1.20 AS BINARY

RUN git clone --depth 1 --branch v1.11.2 https://github.com/coredns/coredns.git /coredns

WORKDIR /coredns
COPY plugin.cfg /coredns/plugin.cfg

RUN \
    make coredns && \
    chmod +x coredns

FROM debian:stable-slim AS SSL

SHELL [ "/bin/sh", "-ec" ]

RUN export DEBCONF_NONINTERACTIVE_SEEN=true \
           DEBIAN_FRONTEND=noninteractive \
           DEBIAN_PRIORITY=critical \
           TERM=linux ; \
    apt-get -qq update ; \
    apt-get -yyqq upgrade ; \
    apt-get -yyqq install ca-certificates libcap2-bin; \
    apt-get clean

FROM gcr.io/distroless/static-debian11:nonroot

COPY --from=SSL /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=BINARY /coredns /coredns

USER nonroot:nonroot

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]