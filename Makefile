all: build

build:
	@docker build --tag=coconutpalm/postgresql .

release: build
	@docker build --tag=coconutpalm/postgresql:$(shell cat VERSION) .

# Assumes you've done a release
run: 
	@docker run --name postgresql -itd --restart always \
	--publish 5432:5432 \
	--env 'PG_TRUST_LOCALNET=true' \
	$(shell cat USER_PW_CONF)
	--volume /srv/docker/postgresql:/var/lib/postgresql \
	coconutpalm/postgresql:$(shell cat VERSION)

