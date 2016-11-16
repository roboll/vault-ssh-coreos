#! /bin/sh

rsync -rupoE /opt/bin/vault-ssh-helper /rootfs/opt/bin/vault-ssh-helper
rsync -rupoE /etc/pam.d/ /rootfs/etc/pam.d/
