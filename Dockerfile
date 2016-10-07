FROM scratch

ADD vault-ssh-helper /opt/bin/vault-ssh-helper
ADD pam /etc/pam.d

ADD link.sh /link.sh
