# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "control" do |control|
    control.vm.box = "ubuntu/xenial64"
    control.vm.network "private_network", ip: "192.168.10.10"
  end

  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/xenial64"
    web.vm.network "private_network", ip: "192.168.10.11"
    web.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.12"
  end

end
