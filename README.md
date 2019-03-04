# nifi-scratch
I wanted to use Nifi.  This project lets you run Nifi, Nifi Registry, and the Nifi toolkit in a vagrant vm.

## Quick start
```
make
make data
make vagrant
```

## Dependencies
Run nifi on a mac:

`brew install nifi`

Run nifi on Vagrant:

`make vagrant`

## Backup and restore

`make backup`

`make restore`

### Troubleshooting

#### Nifi is not getting the file after it's created on the command line
```
vagrant halt
vagrant up
```
For some reason the folders stop syncing.  A workaround is to `vagrant ssh`, and `touch` the file.  Restart of the VM also seems to help.

To look at Nifi logs:

`tail -f /opt/nifi-1.9.0/logs/nifi-app.log`

## Resources
- Docker: https://hub.docker.com/r/apache/nifi
- Nifi Docs: https://nifi.apache.org/docs.html
- Nifi Registry Docs: https://nifi.apache.org/docs/nifi-registry-docs/index.html
- CSV To Avro: https://www.linkedin.com/pulse/converting-csv-avro-apache-nifi-jeremy-dyer/
- Python Faker (to generate fake data): https://pypi.org/project/Faker/
- Ruby Faker (to generate fake data): https://github.com/stympy/fake
