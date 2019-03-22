# nifi-scratch
I wanted to use Nifi.  This project lets you run Nifi, Nifi Registry, and the Nifi toolkit in a vagrant vm.

## Quick start
```
make
make data
make vagrant
```

## Dependencies
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
- Ruby Faker (to generate fake data): https://github.com/stympy/fake

### Securing Nifi
There are two options for generating the necessary CA, cert, and keystore:
1. Create a 'tinycert' account: https://www.tinycert.org/signup
  1. Create your own Certificate Authority (CA)
  1. Create your own client certificate
  1. Create your own server certificate
  1. Download CA to project folder
    - cacert.pem
  1. Download client certificate to the project directory (PKCS#12 Archive)
    - client.pfx
  1. Download client certificate to the project directory (PKCS#12 Archive)
    - server.pfx
  1. manually change the nifi.properties file in /opt/nifi-1.9.0/conf
1. Use TLS-Toolkit that that's installed with nifi during `vagrant up`
  1. /opt/nifi-1.9.0/bin/tls-toolkit.sh standalone -n 'localhost(1)' -C 'CN=nifi,OU=NIFI' -o /opt

References:
- https://www.batchiq.com/nifi-configuring-ssl-auth.html
- https://community.hortonworks.com/articles/886/securing-nifi-step-by-step.html
- https://community.hortonworks.com/articles/17293/how-to-create-user-generated-keys-for-securing-nif.html
- https://bryanbende.com/development/2016/08/17/apache-nifi-1-0-0-authorization-and-multi-tenancy

### Nifi How Tos
- CSV To Avro: https://www.linkedin.com/pulse/converting-csv-avro-apache-nifi-jeremy-dyer/
