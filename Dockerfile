FROM alpine:3.4

RUN apk add --update --no-cache rsync

ADD vault-ssh-helper /opt/bin/vault-ssh-helper
ADD rootfs /

ENTRYPOINT ["/install.sh"]
