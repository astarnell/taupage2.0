# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.ssh.insert_key = false
  config.ssh.username = "core"
  config.ssh.forward_agent = true

  config.vm.box_check_update = true
  config.vm.box = "./taupage.box"
 
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.cpus = 2
    vb.memory = "1024"
    
    vb.check_guest_additions = false
    vb.functional_vboxsf     = false
    
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end
      
  config.vm.network :private_network, ip: "172.17.8.3", virtualbox__intnet: true
  #config.vm.network :private_network, type: "dhcp"
  
  config.vm.synced_folder "~/.aws", "/home/core/.aws", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']
end
