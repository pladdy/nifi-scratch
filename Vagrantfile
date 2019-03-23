# configure with version "2"
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = true
  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 2048
  end

  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true # nifi http
  config.vm.network "forwarded_port", guest: 9443, host: 9443, auto_correct: true # nifi https
  config.vm.network "forwarded_port", guest: 18080, host: 18080, auto_correct: true # nifi registry

  config.vm.synced_folder "data", "/var/data" # for syncing data
  config.vm.synced_folder "nifi-flow", "/opt/nifi-flow" # for backing up flow config file

  # avoid 'Innapropriate ioctl for device' messages
  # see vagrant config doc for more info: https://www.vagrantup.com/docs/vagrantfile/ssh_settings.html
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provision "bootstrap", type: "shell" do |s|
    s.inline = <<-SHELL
    apt-get update
    apt-get install -y default-jre default-jdk
    SHELL
  end

  config.vm.provision "nifi-install", type: "shell" do |s|
    s.inline = <<-SHELL
    set -euo pipefail
    /vagrant/vagrant/install-nifi
    systemctl start nifi

    /vagrant/vagrant/install-nifi-toolkit

    /vagrant/vagrant/install-nifi-registry
    systemctl start nifi-registry
    SHELL
  end

  # explicit provision commands

  config.vm.provision "nifi-backup", type: "shell", run: "never" do |s|
    s.inline = <<-SHELL
    set -euo pipefail
    /opt/nifi-toolkit-1.9.0/bin/file-manager.sh \
      -v \
      --operation backup \
      --backupDir /vagrant/vagrant/nifi-backup  \
      --nifiCurrentDir /opt/nifi-1.9.0
    SHELL
  end

  config.vm.provision "nifi-certs", type: "shell", run: "never" do |s|
    s.inline = <<-SHELL
    set -euo pipefail

    /opt/nifi-toolkit-1.9.0/bin/tls-toolkit.sh standalone -n 'localhost(1)' -C 'CN=nifi, OU=NIFI' -o /opt
    cp /opt/nifi-1.9.0/conf/nifi.properties /opt/nifi-1.9.0/conf/nifi.properties.bak
    cp /opt/localhost/* /opt/nifi-1.9.0/conf
    cp /opt/CN* /vagrant

    # create crt from p12
    mkdir /usr/local/share/ca-certificates/nifi
    chmod 755 /usr/local/share/ca-certificates/nifi

    openssl pkcs12 -in /opt/CN\=nifi_OU\=NIFI.p12 \
      -clcerts -nokeys \
      -out /usr/local/share/ca-certificates/nifi/nifi-client.crt \
      -passin file:/opt/CN\=nifi_OU\=NIFI.password

    update-ca-certificates
    SHELL
  end

  # TODO: convert to provisioner and have alternate method to secure nifi without toolkit
  #trust_store = "/top/truststore.jks"
  #rm #{trust_store}
  #keytool -import -file /vagrant/cacert.pem -alias cacert -keystore #{trust_store} -storepass trustme -noprompt

  config.vm.provision "nifi-flow-backup", type: "shell", run: "never" do |s|
    s.inline = <<-SHELL
    cp /opt/nifi-1.9.0/conf/flow.xml.gz /opt/nifi-flow
    SHELL
  end

  config.vm.provision "nifi-restore", type: "shell", run: "never" do |s|
    s.inline = <<-SHELL
    set -euo pipefail
    systemctl stop nifi
    systemctl stop nifi-registry

    /opt/nifi-toolkit-1.9.0/bin/file-manager.sh \
      -v \
      --operation restore \
      --backupDir /vagrant/vagrant/nifi-backup \
      --nifiRollbackDir /opt/nifi-1.9.0

    systemctl start nifi
    systemctl start nifi-registry
    SHELL
  end

  config.vm.provision "nifi-restore-flow", type: "shell", run: "never" do |s|
    s.inline = <<-SHELL
    set -euo pipefail
    echo "Restoring flow"
    cp /opt/nifi-flow/flow.xml /opt/nifi-1.9.0/conf
    gzip -f /opt/nifi-1.9.0/conf/flow.xml
    SHELL
  end

  config.vm.provision "nifi-start", type: "shell", run: "never" do |s|
    s.inline = <<-SHELL
    set -euo pipefail
    echo "Starting nifi"
    systemctl start nifi
    systemctl start nifi-registry
    SHELL
  end

  config.vm.provision "nifi-stop", type: "shell", run: "never" do |s|
    s.inline = <<-SHELL
    set -euo pipefail
    echo "Stopping nifi"
    systemctl stop nifi
    systemctl stop nifi-registry
    SHELL
  end
end
