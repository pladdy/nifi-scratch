.PHONY: docker mac-dependencies mac-python python-dependencies vagrant

all: python-dependencies

data:
	#pipenv run pytest -s -v
	bundle exec scripts/fake-data
	
docker:
	docker run --name nifi -p 8080:8080 -d apache/nifi:latest

mac-dependencies: mac-python python-dependencies

mac-python:
	-brew install python3

python-dependencies:
	pip3 install pipenv
	pipenv install

vagrant:
	vagrant up
	open http://localhost:8080/nifi/

vendor:
	bundle install --path $@
