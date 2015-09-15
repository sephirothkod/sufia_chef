# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "sufia-berkshelf"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "trusty64-cloud"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # Forward port mappings
  config.vm.network :forwarded_port, guest: 8080, host: 8282    # Tomcat
  config.vm.network :forwarded_port, guest: 3306, host: 3307    # MySQL
  config.vm.network :forwarded_port, guest: 5432, host: 5432    # PostgreSQL
  config.vm.network :forwarded_port, guest: 80,   host: 8181    # Apache
  config.vm.network :forwarded_port, guest: 3000,   host: 3001    # Rails
  config.vm.network :forwarded_port, guest: 8983,   host: 8983    # Jetty

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", '3000']
  end

  # Enabling the Berkshelf plugin
  config.berkshelf.enabled = true

  # Install a specific version of Chef on the node
  # Needed to workaround https://tickets.opscode.com/browse/CHEF-5041 ; https://tickets.opscode.com/browse/CHEF-5100
  config.omnibus.chef_version = '11.6.2'

	config.vm.provision "fix-no-tty", type: "shell" do |s|
	  s.privileged = false
	  s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
	end

  config.vm.provision :chef_solo do |chef|
    # Log the heck out of everything
    chef.log_level = :debug
    chef.formatter = :doc

    chef.json = {
     
    }
    chef.add_recipe 'ubuntu-baseline'
    chef.add_recipe 'sufia'
  end
end
