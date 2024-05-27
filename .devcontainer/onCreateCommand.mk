.DEFAULT_GOAL:=setup
PROTO_VERSION?=
PROTO_HOME?=

.PHONY: setup
setup: configure-locale install-proto prepare

.PHONY: configure-locale
configure-locale:
	echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen
	locale-gen

.PHONY: install-proto
install-proto: configure-locale
	test -n '$(PROTO_VERSION)'
	test -n '$(PROTO_HOME)'
	curl -fsSL https://moonrepo.dev/install/proto.sh | bash -s -- $(PROTO_VERSION) --yes --no-profile

.PHONY: prepare
prepare: configure-locale install-proto
	proto use
	moon setup
