FROM golang:${GO_VERSION} AS BINARY

RUN git clone --depth 1 --branch ${COREDNS_VERSION} https://github.com/coredns/coredns.git /coredns

WORKDIR /coredns
COPY plugin.cfg /coredns/plugin.cfg

RUN \
    make coredns && \
    chmod +x coredns

FROM debian:stable-slim AS SSL

RUN apt-get update && apt-get -uy upgrade
RUN apt-get -y install ca-certificates && update-ca-certificates

FROM scratch

COPY --from=SSL /etc/ssl/certs /etc/ssl/certs
COPY --from=BINARY /coredns/coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]