VAGRANTFILE_API_VERSION = "2"
DEFAULT_BOX = "centos/7"
DOMAIN_NAME = ".infra.ci.local"
HOSTS_MEMORY = 1024
HOSTS_CPUS = 1

#############################################################################

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.ssh.forward_agent = true

  $kmaster_script = <<SCRIPT
    yum -y update &> /dev/null
    echo "===CentOS updated"
    yum -y install docker v=1.12.6 kubernetes kubernetes-client kubernetes-master &> /dev/null
    echo "===Base master packages installed"
SCRIPT

  $knode_script = <<SCRIPT
    yum -y update &> /dev/null
    echo "===CentOS updated"
    yum -y install docker v=1.12.6 kubernetes kubernetes-node &> /dev/null
    echo "===Base node packages installed"
SCRIPT

  $hosts_setup = <<SCRIPT
    echo "192.168.11.99 lb" >> /etc/hosts
    echo "192.168.11.100 kmaster1" >> /etc/hosts
    echo "192.168.11.101 kmaster2" >> /etc/hosts
    echo "192.168.11.102 kmaster3" >> /etc/hosts
    echo "192.168.11.110 knode1" >> /etc/hosts
    echo "192.168.11.111 knode2" >> /etc/hosts
SCRIPT

  config.vm.provider "virtualbox" do |v|
    v.memory = HOSTS_MEMORY
    v.cpus = HOSTS_CPUS
  end

  config.vm.define "lb" do |lb|
    lb.vm.box = DEFAULT_BOX
    lb.vm.hostname = "lb" + DOMAIN_NAME
    ln.vm.network "private_network", ip: "192.168.11.99", netmask: "255.255.255.0"
    config.vm.provision "shell", inline: $hosts_setup
  end

  config.vm.define "kmaster1" do |kmaster1|
    kmaster1.vm.box = DEFAULT_BOX
    kmaster1.vm.hostname = "kmaster1" + DOMAIN_NAME
    kmaster1.vm.network "private_network", ip: "192.168.11.100", netmask: "255.255.255.0"
    config.vm.provision "shell", inline: $kmaster_script
    config.vm.provision "shell", inline: $hosts_setup
  end

  config.vm.define "kmaster2" do |kmaster2|
    kmaster2.vm.box = DEFAULT_BOX
    kmaster2.vm.hostname = "kmaster2" + DOMAIN_NAME
    kmaster2.vm.network "private_network", ip: "192.168.11.101", netmask: "255.255.255.0"
    config.vm.provision "shell", inline: $kmaster_script
    config.vm.provision "shell", inline: $hosts_setup
  end

  config.vm.define "kmaster3" do |kmaster3|
    kmaster3.vm.box = DEFAULT_BOX
    kmaster3.vm.hostname = "kmaster3" + DOMAIN_NAME
    kmaster3.vm.network "private_network", ip: "192.168.11.102", netmask: "255.255.255.0"
    config.vm.provision "shell", inline: $kmaster_script
    config.vm.provision "shell", inline: $hosts_setup
  end

  config.vm.define "knode1" do |knode1|
    knode1.vm.box = DEFAULT_BOX
    knode1.vm.hostname = "knode1" + DOMAIN_NAME
    kmaster3.vm.network "private_network", ip: "192.168.11.110", netmask: "255.255.255.0"
    config.vm.provision "shell", inline: $knode_script
    config.vm.provision "shell", inline: $hosts_setup
  end

  config.vm.define "knode2" do |knode2|
    knode2.vm.box = DEFAULT_BOX
    knode2.vm.hostname = "knode2" + DOMAIN_NAME
    kmaster3.vm.network "private_network", ip: "192.168.11.111", netmask: "255.255.255.0"
    config.vm.provision "shell", inline: $knode_script
    config.vm.provision "shell", inline: $hosts_setup
  end
end
