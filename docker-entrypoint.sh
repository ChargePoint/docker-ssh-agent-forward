#!/bin/sh
set -eo pipefail

echo "root:$(head -c${1:-16} /dev/urandom | base64 | tr -dc _A-Z-a-z-0-9)"|chpasswd

echo "$AUTHORIZED_KEYS" | base64 -d >/root/.ssh/authorized_keys

chown root:root /root/.ssh/authorized_keys

ssh-keygen -A

exec "$@"
