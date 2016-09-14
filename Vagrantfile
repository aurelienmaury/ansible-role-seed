# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

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

      v.memory = 1024
      v.cpus = 2
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    end

  end

  config.vm.define "bobby" do |centosbox|

    centosbox.vm.box = "centos/7"

    centosbox.vm.box_check_update = false
    centosbox.vbguest.auto_update = false

    centosbox.vm.network "public_network", bridge: [
        "en1: Wi-Fi (AirPort)",
        "en0: Ethernet",
        "en1: Intel(R) Dual Band Wirelass-AC 8260",
        "en0: Ethernet Connection I219-V"
    ]

    centosbox.vm.synced_folder ".", "/vagrant", disabled: true

    centosbox.vm.provider "virtualbox" do |v|

      v.memory = 1024
      v.cpus = 2
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    end

  end

  config.vm.provision "ansible" do |ansible|

    ansible.playbook = "local.yml"
    ansible.groups = {
        "boxes" => ["jessie", "bobby"],
        "all_groups:children" => ["boxes"]
    }
    ansible.verbose = true

  end

end
