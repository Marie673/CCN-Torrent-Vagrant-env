# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.ssh.insert_key = false
  config.ssh.private_key_path = "~/.ssh/vagrant/insecure_private_key"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = 8192
    vb.cpus = 2
    # vb.customize ["modifyvm", :id, "--ipapic", "on"]
  end

  config.vm.synced_folder "./.share", "/share"

  config.vm.define "router" do |router|
    router.vm.hostname = "router"
    router.vm.network "private_network", ip: "192.168.60.101", virtualbox__intnet: true
    router.vm.network "private_network", ip: "192.168.61.101", virtualbox__intnet: true
    router.vm.network "public_network", bridge: "enp6s0"

    router.vm.provision :shell, path: "base.sh"
    router.vm.provision :shell, path: "install_cefore.sh"

    router.vm.provision :shell, run: "always", path: "buffa_tune.sh"
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client"
    client.vm.network "private_network", ip: "192.168.60.101", virtualbox__intnet: true
    client.vm.network "public_network", bridge: "enp6s0"

    client.vm.provision :shell, path: "base.sh"
    client.vm.provision :shell, path: "install_cefore.sh"

    client.vm.provision :shell, run: "always", path: "buffa_tune.sh"
  end

  config.vm.define "proxy" do |proxy|
    proxy.vm.hostname = "proxy"
    proxy.vm.network "private_network", ip: "192.168.61.103", virtualbox__intnet: true
    proxy.vm.network "private_network", ip: "192.168.62.103", virtualbox__intnet: true
    proxy.vm.network "public_network", bridge: "enp6s0"

    proxy.vm.provision :shell, path: "base.sh"
    proxy.vm.provision :shell, path: "install_cefore.sh"

    proxy.vm.provision :shell, run: "always", path: "buffa_tune.sh"
  end

  config.vm.define "qbittorrent" do |qbittorrent|
    qbittorrent.vm.hostname = "qbittorrent"
    qbittorrent.vm.network "private_network", ip: "192.168.62.104", virtualbox__intnet: true
    qbittorrent.vm.network "public_network", bridge: "enp6s0"

    qbittorrent.vm.provision :shell, path: "base.sh"

  end
end