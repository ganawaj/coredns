FROM coredns/coredns

FROM ubuntu

RUN apt-get update -y

RUN apt-get install \
  curl \
  openssh-client \
  git -y

COPY --from=0 /etc/ssl/certs /etc/ssl/certs
COPY --from=0 /coredns /coredns

COPY ./src/entrypoint.sh /root/entrypoint.sh

RUN \
  mkdir -p /root/.ssh && \
  chmod 700 /root/.ssh && \
  touch /root/.ssh/known_hosts && \
  chmod 600 /root/.ssh/known_hosts && \
  ssh-keyscan github.com >> /root/.ssh/known_hosts

COPY ./src/ssh_config /tmp/.ssh_config
RUN \
  chown root:root /tmp/.ssh_config && \
  chmod 0644 /tmp/.ssh_config

EXPOSE 53 53/udp
VOLUME ["/etc/coredns"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-conf", "/etc/coredns/Corefile"]