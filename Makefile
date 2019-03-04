.PHONY: data docker mac-dependencies vagrant vendor

all: mac-dependencies vagrant

data/new:
	mkdir -p $@

data/processed:
	mkdir -p $@

data: data/processed data/new vendor
	bundle exec scripts/create-fake-data

flow-backup: nifi-flow
	vagrant provision --provision-with backup-nifi-flow
	gunzip $</flow.xml.gz

mac-dependencies: mac-ruby vendor

mac-ruby:
	brew install rbenv
	rbenv install -s

nifi-backup: vagrant
	vagrant provision --provision-with backup-nifi

nifi-flow:
	makedir $@

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
