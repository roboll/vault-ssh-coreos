#! /bin/sh
set -eo pipefail
set -x

export VAULT_ADDR=http://localhost:8200
export VAULT_SKIP_VERIFY=true

init="$(vault init -key-shares=1 -key-threshold=1)"

key="$(echo "$init" | grep "Unseal Key 1 (hex)" | sed -re "s,[^:]*: (.*)$,\1,g")"
token="$(echo "$init" | grep "Root Token" | sed -re "s,[^:]*: (.*)$,\1,g")"

echo "unseal key is $key"
vault unseal $key

export VAULT_TOKEN=$token

vault mount ssh
vault write ssh/roles/otp \
    key_type=otp \
    default_user=core \
    cidr_list=0.0.0.0/0

pass=$(vault ssh -no-exec -role otp core@localhost | grep "key " | sed -re s,key[\s]*(.*),\\1,g)
echo "pass is $pass"
