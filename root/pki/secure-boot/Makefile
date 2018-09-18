.PHONY: all
.SUFFIXES:
.SECONDARY: # Don't remove intermediate files.

all: PK.auth PK-remove.auth KEK.auth db.auth

%.key %.crt:
	mkdir -p $(@D)
	openssl req -newkey rsa:2048 -nodes -keyout $(@:.crt=.key) -new -x509 -sha256 -days 3650 -subj "/CN=$(shell hostname) $(subst /,-,$(basename $(@)))/" -out $(@:.key=.crt)

%.cer: %.crt
	openssl x509 -outform DER -in $< -out $@

%.guid:
	uuidgen --random > $@

%.esl: %.crt %.guid
	cert-to-efi-sig-list -g $(<:.crt=.guid) $< $@

PK.auth: PK.key PK.crt PK.esl
	sign-efi-sig-list -k PK.key -c PK.crt PK PK.esl $@

PK-remove.auth: PK.key PK.crt
	sign-efi-sig-list -k PK.key -c PK.crt PK /dev/null $@

KEK.auth: PK.key PK.crt KEK.esl
	sign-efi-sig-list -k PK.key -c PK.crt KEK KEK.esl $@

db.auth: KEK.key KEK.crt db.esl
	sign-efi-sig-list -k KEK.key -c KEK.crt db db.esl $@

db.esl: db/kernel.esl db/keytool.esl db/shell.esl
	cat $^ > $@
