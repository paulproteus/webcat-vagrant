# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # We base ourselves off the trusty (Ubuntu 14.04) base box.
  config.vm.box = "trusty64"

  # The url from which to fetch that base box.
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # We forward port 8080, the Web-CAT web port.
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  # Use a shell script to "provision" the box. This install Sandstorm using
  # the bundled installer.
  config.vm.provision "shell",
    inline: "cd /vagrant && echo localhost > /etc/hostname && hostname localhost && cd /vagrant && sudo ./install.sh"

  # Calculate the number of CPUs and the amount of RAM the system has,
  # in a platform-dependent way; further logic below.
  cpus = nil
  total_kB_ram = nil

  host = RbConfig::CONFIG['host_os']
  if host =~ /darwin/
    cpus = `sysctl -n hw.ncpu`.to_i
    total_kB_ram =  `sysctl -n hw.memsize`.to_i / 1024
  elsif host =~ /linux/
    cpus = `nproc`.to_i
    total_kB_ram = `grep MemTotal /proc/meminfo | awk '{print $2}'`.to_i
  end

  # Use the same number of CPUs within Vagrant as the system, with 1
  # as a default.
  #
  # Use at least 512MB of RAM, and if the system has more than 2GB of
  # RAM, use 1/4 of the system RAM. This seems a reasonable compromise
  # between having the Vagrant guest operating system not run out of
  # RAM entirely (which it basically would if we went much lower than
  # 512MB) and also allowing it to use up a healthily large amount of
  # RAM so it can run faster on systems that can afford it.
  config.vm.provider :virtualbox do |vb|
    if cpus.nil?
      vb.cpus = 1
    else
      vb.cpus = cpus
    end

    if total_kB_ram.nil? or total_kB_ram < 2048000
      vb.memory = 512
    else
      vb.memory = (total_kB_ram / 1024 / 4)
    end
  end
end
