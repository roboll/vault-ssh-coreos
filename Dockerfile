FROM alpine:3.4

ADD vault-ssh-helper /opt/bin/vault-ssh-helper
ADD rootfs /

ENTRYPOINT ["/install.sh"]
