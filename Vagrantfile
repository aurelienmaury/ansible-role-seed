# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "testbox" do |debianbox|

    debianbox.vm.box = "ubuntu/xenial64"

    debianbox.vm.box_check_update = false
    debianbox.vbguest.auto_update = false

    debianbox.vm.network "public_network", bridge: [
        "en1: Wi-Fi (AirPort)",
        "en0: Ethernet",
        "en1: Intel(R) Dual Band Wirelass-AC 8260",
        "en0: Ethernet Connection I219-V"
    ]

    debianbox.vm.synced_folder ".", "/vagrant", disabled: true

    debianbox.vm.provider "virtualbox" do |v|

      v.memory = 512
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    end

  end

  config.vm.define "jessie" do |debianbox|

    debianbox.vm.box = "debian/jessie64"

    debianbox.vm.box_check_update = false
    debianbox.vbguest.auto_update = false

    debianbox.vm.network "public_network", bridge: [
        "en1: Wi-Fi (AirPort)",
        "en0: Ethernet",
        "en1: Intel(R) Dual Band Wirelass-AC 8260",
        "en0: Ethernet Connection I219-V"
    ]

    debianbox.vm.synced_folder ".", "/vagrant", disabled: true

    debianbox.vm.provider "virtualbox" do |v|

      v.memory = 512
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    end

  end

  config.vm.define "bobby" do |debianbox|

    debianbox.vm.box = "centos/7"

    debianbox.vm.box_check_update = false
    debianbox.vbguest.auto_update = false

    debianbox.vm.network "public_network", bridge: [
        "en1: Wi-Fi (AirPort)",
        "en0: Ethernet",
        "en1: Intel(R) Dual Band Wirelass-AC 8260",
        "en0: Ethernet Connection I219-V"
    ]

    debianbox.vm.synced_folder ".", "/vagrant", disabled: true

    debianbox.vm.provider "virtualbox" do |v|

      v.memory = 512
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    end

  end

  config.vm.provision "ansible" do |ansible|

    ansible.playbook = "vagrant.yml"
    ansible.groups = {
        "boxes" => ["testbox", "jessie", "bobby"],
        "all_groups:children" => ["boxes"]
    }
    ansible.verbose = true

  end

end
