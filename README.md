## Dependencies
Run nifi on a mac:

`brew install nifi`

Run nifi on Vagrant:

`make vagrant`

Run nifi on Docker:

Not functioning yet...

`make docker`

## Setup
Installed this package:

`pipenv install faker`

## Backup and restore
On a vagrant:

Backup:

`sudo /opt/nifi-toolkit-1.9.0/bin/file-manager.sh --operation=backup --backupDir=/vagrant/vagrant/nifi-backup  --nifiCurrentDir /opt/nifi-1.9.0`

Restore:
TODO: can't same current and rollback dirs
`sudo /opt/nifi-toolkit-1.9.0/bin/file-manager.sh --operation=restore --backupDir=/vagrant/vagrant/nifi-backup --nifiCurrentDir /opt/nifi-1.9.0 --nifiRollbackDir /opt/nifi-1.9.0`

## Resources
- Docker: https://hub.docker.com/r/apache/nifi
- Nifi Docs: https://nifi.apache.org/docs.html
- Nifi Registry Docs: https://nifi.apache.org/docs/nifi-registry-docs/index.html
- Python Faker (to generate fake data): https://pypi.org/project/Faker/
- Ruby Faker (to generate fake data): https://github.com/stympy/fake
