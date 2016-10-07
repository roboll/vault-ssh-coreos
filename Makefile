PREFIX  := quay.io/roboll/vault-ssh-coreos
VERSION := 0.1.2
OS      := linux
ARCH    := amd64

ZIPFILE := vault-ssh-helper_${VERSION}_${OS}_${ARCH}.zip
DL_SITE := https://releases.hashicorp.com/vault-ssh-helper/${VERSION}

checksums:
	curl ${DL_SITE}/vault-ssh-helper_${VERSION}_SHA256SUMS -o ./checksums

checksums.sig:
	curl ${DL_SITE}/vault-ssh-helper_${VERSION}_SHA256SUMS.sig -o ./checksums.sig

download: checksums checksums.sig
	curl ${DL_SITE}/${ZIPFILE} -o ./${ZIPFILE}
	gpg --recv 51852D87348FFC4C
	gpg --verify checksums.sig checksums
	grep ${OS}_${ARCH} checksums > checksum && shasum -a 256 -c checksum
	unzip ${ZIPFILE}
.PHONY: download

container: download
	docker build -t $(PREFIX):$(VERSION) .
.PHONY: container

push: container
	docker push $(PREFIX):$(VERSION)
.PHONY: push
