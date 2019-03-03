.PHONY: data docker mac-dependencies mac-python python-dependencies vagrant

all: python-dependencies

data/new:
	mkdir -p $@

data/processed:
	mkdir -p $@

data: data/processed data/new
	#pipenv run pytest -s -v
	@bundle exec scripts/fake-data

docker:
	docker run --name nifi -p 8080:8080 -d apache/nifi:latest

mac-dependencies: mac-python python-dependencies

mac-python:
	-brew install python3

python-dependencies:
	pip3 install pipenv
	pipenv install

vagrant/nifi-backup:
	mkdir -p $@

vagrant/packages:
	mkdir -p $@

vagrant: vagrant/nifi-backup vagrant/packages
	vagrant up
	open http://localhost:8080/nifi/
	open http://localhost:18080/nifi-registry/

vendor:
	bundle install --path $@
