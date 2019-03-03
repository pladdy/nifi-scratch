.PHONY: data docker mac-dependencies vagrant vendor

all: vendor

data/new:
	mkdir -p $@

data/processed:
	mkdir -p $@

data: data/processed data/new
	#pipenv run pytest -s -v
	@bundle exec scripts/fake-data

docker:
	docker run --name nifi -p 8080:8080 -d apache/nifi:latest

mac-dependencies: mac-ruby vendor

mac-ruby:
	brew install rbenv
	rbenv install -s

nifi-backup: vagrant
	vagrant provision --provision-with backup-nifi

nifi-install: vagrant
	vagrant provision --provision-with install-nifi

nifi-restore: vagrant
	vagrant provision --provision-with restore-nifi

nifi-run: vagrant
	open http://localhost:8080/nifi/
	open http://localhost:18080/nifi-registry/

vagrant/nifi-backup:
	mkdir -p $@

vagrant/packages:
	mkdir -p $@

vagrant: vagrant/nifi-backup vagrant/packages
	vagrant up

vendor:
	bundle install --path $@
