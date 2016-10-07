# vault-ssh-coreos

[Vault SSH]() PAM configuration for CoreOS.

## About

PAM configuration for allowing Vault OTP SSH access to CoreOS instances. Rather than override the default sshd on CoreOS, use `rkt image extract` to extract the contents to a directory, and run [`link.sh`](link.sh) to sync the contents to the root file system. Includes a [minimal PAM modification](pam/system-auth#L4), [vault-ssh-helper PAM file](pam/vault), and `vault-ssh-helper` binary.

The config file `/etc/vault/ssh.hcl` is up to you to provide.

## Install

Check out the [Vagrant config](./test/vagrant/user-data.yaml#L12) used for testing.

```
[Service]
Type=oneshot

ExecStartPre=/bin/mkdir -p /tmp/vault-ssh
ExecStartPre=/usr/bin/rkt fetch --trust-keys-from-https quay.io/roboll/vault-ssh-coreos:v0.1
ExecStart=/usr/bin/rkt image extract quay.io/roboll/vault-ssh-coreos:v0.1 /tmp/vault-ssh
ExecStartPost=/tmp/vault-ssh/link.sh
```
