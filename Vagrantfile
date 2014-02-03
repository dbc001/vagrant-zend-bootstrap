# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Ubuntu 12.04 32 bit
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"


  # Forward ports (for zend server admin mainly)
  config.vm.network :forwarded_port, guest: 80, host: 8080 # http
  config.vm.network :forwarded_port, guest: 10081, host: 10081 # admin interface http
  config.vm.network :forwarded_port, guest: 10082, host: 10082 # admin interface https
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # mysql

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.10"


  # This is our bootstrap script for installing Zend and whatever else we need.
  config.vm.provision :shell, :path => "bootstrap.sh"

  # Share project root folder with /var/www. May need to change in the future.
  config.vm.synced_folder "./", "/var/www", id: "vagrant-root", :nfs => false

  # Virtualbox settings. Mainly for 1024mb memory.
  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    virtualbox.customize ["modifyvm", :id, "--memory", "1024"]
    virtualbox.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end


end
