# vault-ssh-coreos [![CircleCI](https://circleci.com/gh/roboll/vault-ssh-coreos.svg?style=svg)](https://circleci.com/gh/roboll/vault-ssh-coreos)

[![Docker Repository on Quay](https://quay.io/repository/roboll/vault-ssh-coreos/status "Docker Repository on Quay")](https://quay.io/repository/roboll/vault-ssh-coreos)

[Vault SSH](https://vaultproject.io) PAM configuration for CoreOS.

## About

PAM configuration for allowing Vault OTP SSH access to CoreOS instances. Rather than override the default sshd on CoreOS, use `rkt` or `docker` to run [`install.sh`](rootfs/install.sh) to sync the contents to the root file system. Includes a [minimal PAM modification](rootfs/etc/pam.d/system-auth#L4), [vault-ssh-helper PAM file](rootfs/etc/pam.d/vault), and `vault-ssh-helper` binary.

The config file `/etc/vault/ssh.hcl` is up to you to provide.

## Install

Check out the [Vagrant config](./test/vagrant/user-data.yaml#L12) used for testing.

```
[Service]
Type=oneshot

ExecStartPre=/usr/bin/rkt fetch --trust-keys-from-https quay.io/roboll/vault-ssh-coreos:v0.2.0
ExecStart=/usr/bin/rkt run --volume --mount quay.io/roboll/vault-ssh-coreos:v0.2.0
```
