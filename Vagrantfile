# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.boot_timeout = 600000
  config.vm.define "dc" do |dc|
    #dc.vm.box = "gusztavvargadr/windows-server"
    #dc.vm.box_version = "2102.0.2402"
    
    #dc.vm.box = "my-packer-win2022"
    
    dc.vm.box = "StefanScherer/windows_2019"
    vm_name = "dc"
    dc.vm.hostname = "dc"
    
    dc.vm.network :private_network, ip: "192.168.56.2", gateway: "192.168.56.1"

    
    dc.vm.communicator = "winrm"
    #dc.winrm.transport = :plaintext
    #dc.winrm.basic_auth_only = true
	  #dc.winrm.password = "packer"
    #dc.winrm.username = "Administrator"
    #dc.winrm.timeout = 600
    #dc.winrm.retry_limit = 20
    

    # Настройка для VirtualBox
    dc.vm.provider "virtualbox" do |vb|
      vb.name = vm_name
      vb.gui = true
    end
    
    #dc.vm.provision "shell", path: "Powershell/config-static.ps1"
    #dc.vm.provision "shell", path: "Powershell/domain-controller.ps1", reboot: true
    #dc.vm.provision "shell", path: "Powershell/forest-configure.ps1", reboot: true
    
	
 
	
    #dc.vm.provision "shell", path: "Powershell/domain-controller-wait-for-ready.ps1"
    
    
    
    
    
    #dc.vm.provision "shell", path: "scripts/provision.ps1", privileged: false, args: "192.168.56.2"
    #dc.vm.provision "shell", reboot: true
    #dc.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
    
    dc.vm.provision "ansible" do |ansible|
      ansible.inventory_path = "hosts.ini"
      ansible.playbook = "ping.yml"
      ansible.limit = "all"
      ansible.verbose = true
    end
  end
end
