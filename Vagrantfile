# -*- mode: ruby -*-
# vi: set ft=ruby :
$commonScript = <<SCRIPT
   echo Installing dependencies...

   # install base tools 
   sudo yum update -y && yum install -y net-tools wget curl python unzip zip cron vim epel-release git

   # private network needs hosts entries
   echo "192.168.50.11 node-1\n192.168.50.12 node-2\n192.168.50.13 node-3" >> /etc/hosts
  
   # jdk
   wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz" -P /opt && cd /opt \
     && tar xvzf jdk-8u111-linux-x64.tar.gz && rm jdk-8u111-linux-x64.tar.gz \
     && ln -s jdk1.8.0_111 jdk
   
   # kafka
   wget http://www-us.apache.org/dist/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz -P /opt \
     && cd /opt \
     && tar xvzf kafka_2.11-0.10.1.1.tgz && rm kafka_2.11-0.10.1.1.tgz \
     && ln -s kafka_2.11-0.10.1.1 kafka
   
   # back up config files 
   CONFIG_DIR=/opt/kafka/config
   cp $CONFIG_DIR/server.properties $CONFIG_DIR/zookeeper.properties-
   cp $CONFIG_DIR/server.properties $CONFIG_DIR/server.properties-
   
   # add config settings to zookeeper.properties
   echo "initLimit=5\nsyncLimit=2" >> $CONFIG_DIR/zookeeper.properties

   # add server nodes to zookeeper.properties
   echo "server.1=192.168.50.11:2888:3888\nserver.2=192.168.50.12:2888:3888\nserver.3=192.168.50.13:2888:3888" >> $CONFIG_DIR/zookeeper.properties
   
   # add server nodes to server.properties
   sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=192.168.50.11:2181,192.168.50.12:2181,192.168.50.13:2181/" $CONFIG_DIR/server.properties

SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", inline: $commonScript
  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  # define nodes
  (1..3).each do |i|
    config.vm.define "node-#{i}" do |node|
       config.vm.provider "virtualbox" do |node| 
         node.name = "kafka-node-#{i}" 
         node.memory = 2048 
         node.cpus = 1 
       end 
       # expose port 388x for zookeeper server to server communication
       node.vm.network "private_network", ip: "192.168.50.1#{i}", netmask: "255.255.255.0", virtualbox__intnet: "kafka-network", drop_nat_interface_default_route: true
       node.vm.hostname = "node-#{i}"
       # expose ports for outside clients to connect to kafka
       node.vm.network "forwarded_port", guest: 9092, host: "909#{i+1}"
       node.vm.provision "shell", inline: "/bin/bash /vagrant/setup.sh #{i}"
    end
  end
end
