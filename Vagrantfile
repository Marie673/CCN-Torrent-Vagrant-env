# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.ssh.insert_key = false
  config.ssh.private_key_path = "~/.ssh/vagrant/insecure_private_key"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = 8192
    vb.cpus = 4
    # vb.customize ["modifyvm", :id, "--ipapic", "on"]
  end

  config.vm.synced_folder "./.share", "/share"

  config.vm.define "client" do |client|
    client.vm.hostname = "client"
    client.vm.network "private_network", ip: "192.168.62.103", virtualbox__intnet: true
    # client.vm.network "public_network", bridge: "enp6s0"

    client.vm.provision :shell, path: "base.sh"
    client.vm.provision :shell, path: "install_cefore.sh"

    client.vm.provision :shell, run: "always", path: "provision/buffa_tune.sh"
    client.vm.provision :shell, run: "always", path: "provision/tc/client.sh"
  end

  config.vm.define "router" do |router|
    router.vm.hostname = "router"
    router.vm.network "private_network", ip: "192.168.61.102", virtualbox__intnet: true
    router.vm.network "private_network", ip: "192.168.62.102", virtualbox__intnet: true
    # router.vm.network "public_network", bridge: "enp6s0"

    router.vm.provision :shell, path: "base.sh"
    router.vm.provision :shell, path: "install_cefore.sh"

    router.vm.provision :shell, run: "always", path: "provision/buffa_tune.sh"
    router.vm.provision :shell, run: "always", path: "provision/tc/router.sh"
  end

  config.vm.define "proxy" do |proxy|
    proxy.vm.hostname = "proxy"
    proxy.vm.network "private_network", ip: "192.168.60.101", virtualbox__intnet: true
    proxy.vm.network "private_network", ip: "192.168.61.101", virtualbox__intnet: true
    # proxy.vm.network "public_network", bridge: "enp6s0"
    proxy.ssh.forward_x11 = true

    proxy.vm.provision :shell, path: "base.sh"
    proxy.vm.provision :shell, path: "install_cefore.sh"

    proxy.vm.provision :shell, run: "always", path: "provision/buffa_tune.sh"
    proxy.vm.provision :shell, run: "always", path: "provision/tc/proxy.sh"
  end

  config.vm.define "qbittorrent" do |qbittorrent|
    qbittorrent.vm.hostname = "qbittorrent"
    qbittorrent.vm.network "private_network", ip: "192.168.60.104", virtualbox__intnet: true
    qbittorrent.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
    qbittorrent.ssh.forward_x11 = true
    # qbittorrent.vm.network "public_network", bridge: "enp6s0"

    qbittorrent.vm.provision :shell, path: "base.sh"
    qbittorrent.vm.provision :shell, path: "qbittorrent_install.sh"

    qbittorrent.vm.provision :shell, run: "always", path: "provision/tc/ip.sh"
  end
end
