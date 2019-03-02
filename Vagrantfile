# configure with version "2"
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = true
  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 2048
  end

  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true

  config.vm.synced_folder "data", "/vagrant/data"

  # avoid 'Innapropriate ioctl for device' messages
  # see vagrant config doc for more info: https://www.vagrantup.com/docs/vagrantfile/ssh_settings.html
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provision "bootstrap", type: "shell" do |s|
    s.inline = <<-SHELL
    apt-get update
    apt-get install -y default-jre default-jdk
    /vagrant/vagrant/install-nifi
    systemctl start nifi
    SHELL
  end
end
