FROM debian:stable-slim AS build

SHELL [ "/bin/sh", "-ec" ]

RUN export DEBCONF_NONINTERACTIVE_SEEN=true \
           DEBIAN_FRONTEND=noninteractive \
           DEBIAN_PRIORITY=critical \
           TERM=linux ; \
    apt-get -qq update ; \
    apt-get -yyqq upgrade ; \
    apt-get -yyqq install ca-certificates libcap2-bin; \
    apt-get clean

COPY artifacts/coredns  /coredns
RUN \
    setcap cap_net_bind_service=+ep /coredns && \
    chmod +x /coredns

FROM gcr.io/distroless/static-debian11:nonroot

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build --chown=nonroot:nonroot /coredns /coredns

USER nonroot:nonroot

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]