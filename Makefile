.PHONY: data docker mac-dependencies vagrant vendor

all: mac-dependencies vagrant

data/new:
	mkdir -p $@

data/processed:
	mkdir -p $@

data: data/processed data/new vendor
	bundle exec scripts/create-fake-data

mac-dependencies: mac-ruby vendor

mac-ruby:
	brew install rbenv
	rbenv install -s

nifi-backup: vagrant
	vagrant provision --provision-with $@

nifi-flow-backup: nifi-flow
	vagrant provision --provision-with $@
	gunzip $</flow.xml.gz

nifi-flow:
	makedir $@

nifi-install: vagrant
	vagrant provision --provision-with $@

nifi-restore: vagrant
	vagrant provision --provision-with $@

nifi-restore-flow:
	vagrant provision --provision-with $@

nifi-run: vagrant
	open http://localhost:8080/nifi/
	open http://localhost:18080/nifi-registry/

nifi-stop: vagrant
	vagrant provision --provision-with $@

vagrant/nifi-backup:
	mkdir -p $@

vagrant/packages:
	mkdir -p $@

vagrant: vagrant/nifi-backup vagrant/packages
	vagrant up

vendor:
	bundle install --path $@
