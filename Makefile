PREFIX  := quay.io/roboll/vault-ssh-coreos
VERSION := $(shell git describe --tags --abbrev=0 HEAD)

static:
	docker run -v ${PWD}:/host -e CGO_ENABLED=0 golang:1.7 bash -c \
		"go get github.com/hashicorp/vault-ssh-helper && \
		cp /go/bin/vault-ssh-helper /host"

container: static
	docker build -t $(PREFIX):$(VERSION) .
.PHONY: container

push: container
	docker push $(PREFIX):$(VERSION)
.PHONY: push
