all: build

build:
	@docker build --tag=coconutpalm/postgresql .

release: build
	@docker build --tag=coconutpalm/postgresql:$(shell cat VERSION) .
