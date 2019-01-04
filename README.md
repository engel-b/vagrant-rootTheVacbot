# rootTheVacbot
This project sets up a complete environment to build and flash custom image (dustcloud, valetudo) to xiaomi vacuum.

There is nothing special, but for me (Windows-User...) it is easier to do a `vagrant up` than to install a complete linux and python 3.5.

## What is in?
* Debian 9
* Python 3.5
* Libs and tools needed by dustcloud and valetudo

## Requirements
* Virtual Box
* Vagrant
* Power Shell 3 (needed by Vagrant)

## How to start?
* clone this repository by download or `git clone https://github.com/justcoke/vagrant-rootTheVacbot.git`
* enter 'vagrant-rootTheVacbot' directory
* run `vagrant up` (this creates a virtual machine in your virtual box and starts it)
  * the 'vagrant-rootTheVacbot' directory will automatically mounted on /vagrant
* run `vagrant ssh` to connect to your vm

## Build and flash the Vacbot using my wrapper-scripts
The scripts online.sh and offline.sh work today (2019-01-04). Probably they wont if something in the used repositories changes. Than you need to read their documentation carefully. But you can use this vm. Or you switch the repositories to my forks (online.sh).

* ensure a public-key exists in /vagrant
  * if not run `ssh-keygen -t rsa -b 4096` and save or copy the generated files to /vagrant/...
* edit the properties.conf in your favorite editor
* run `/vagrant/online.sh`
  * the wrapper-script
    * clones dustcloud and valetudo repository
    * patches a bug that avoids getting the correct ip of your vm
    * downloads the vacbot-firmware
    * runs dustcloud's imagebuilder.sh with your arguments from properties.config
* change your wifi to the vacbot-wifi (press reset button next to the wifi led)
* ensure your vm gets an ip address from the vacbot (I had to logout from vm, run `vagrant halt`, `vagrant up` and `vagrant ssh` again)
* run `/vagrant/offline.sh`
* after flashing your vacbot should give you a verbal note that it updates it's firmware
* if it is finished completely you get another another
 and your private key

Have fun
