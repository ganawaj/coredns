#!/bin/bash

set -e

if [[ -f /root/.ssh/id_rsa.github.pem ]]; then

    mv /tmp/.ssh_config /root/.ssh/config
    chown root:root /root/.ssh/id_rsa.github.pem
    chmod 600 /root/.ssh/id_rsa.github.pem
    
fi

/coredns "$@"