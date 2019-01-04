Vagrant.configure("2") do |config|
  config.vm.define "rootTheVacbot"
  config.vm.box = "generic/debian9"

  config.trigger.after :up do |trigger|
    trigger.name = "How to run"
    trigger.info = "Do a vagrant ssh."
  end

  config.vm.network "public_network"

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision 'shell', path: 'install-python'
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y libffi-dev libssl-dev ccrypt git python3-pip

	  pip3 install -U setuptools
    pip3 install python-miio

	  rm /etc/motd
	  ln -s /vagrant/howto.txt /etc/motd

  SHELL
end
