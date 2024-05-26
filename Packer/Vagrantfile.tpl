Vagrant.configure(2) do |config|
  config.vm.guest = :windows
  config.vm.boot_timeout = 600

  config.vm.communicator = 'winrm'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end
end