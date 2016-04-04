all: build

build:
	docker build --tag=coconutpalm/postgresql .

release: build
	docker build --tag=coconutpalm/postgresql:$(shell cat VERSION) .

# Assumes you've done a release
USER_OPTS=$(shell cat USER_PW_CONF)  # Make sure this doesn't have a trailing newline

run:
	docker run --name postgresql -itd --restart always \
	--publish 5432:5432 \
	--env 'PG_TRUST_LOCALNET=true' \
	${USER_OPTS} \
	--volume /srv/docker/postgresql:/var/lib/postgresql \
	coconutpalm/postgresql:$(shell cat VERSION)
