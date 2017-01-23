# Apache Kafka cluster setup 
This project creates a three node [Apache Kafaka](https://kafka.apache.org) cluster on a Vagrant provisioned Centos 7 VM. 

# Prerequisites
* Download and Install <a href="https://www.virtualbox.org/wiki/Downloads" target="_blank">Virtual Box</a>
* Download and Install <a href="https://www.vagrantup.com/downloads.html" target="_blank">Vagrant</a>
* Windows users download and Install <a href="https://git-scm.com/downloads" target="_blank">Git Bash</a>   
    when prompted:
      * Select 'Use Git from Git Bash Only'   
      * Select 'Check out as-is, commit as-is'

### Commands
```ShellSession
git clone https://github.com/PaulSRusso/kafka-cluster.git
cd kafka-cluster
vagrant up
```

### A private network is created   
node-1 | 192.168.50.11 | 9091  
node-2 | 192.168.50.12 | 9092   
node-3 | 192.168.50.13 | 9093   

### To test the system, open three separate terminals

### Terminal 1: Create a topic in node-1
```ShellSession
vagrant ssh node-1
[vagrant@node-1:~] create-topic.sh topic1
```

### Terminal 2: Produce a message in node-2
```ShellSession
vagrant ssh node-2
[vagrant@node-2:~] producer.sh topic1
Hello Kafka 
[ctrl-c]
```

### Terminal 3: Recieve the message in node-3
```ShellSession
vagrant ssh node-3
[vagrant@node-3:~] consumer.sh topic1
Hello Kafka 
[ctrl-c]
```

### Terminals 2 & 1: Recieve the same message in node-2 and node-1
```ShellSession
vagrant ssh node-2
[vagrant@node-2:~] consumer.sh topic1
Hello Kafka 
[ctrl-c]

vagrant ssh node-1
[vagrant@node-1:~] consumer.sh topic1
Hello Kafka 
[ctrl-c]
```
### Customizations made
1. Kafka is installed in /opt/kafka
2. appended entries to /opt/kafka/config/**zookeeper.properties**
   * added config settings
```
     initLimit=5
     nsyncLimit=2
```
   * added server info
```   
     server.1=192.168.50.11:2888:3888  
     server.2=192.168.50.12:2888:3888  
     server.3=192.168.50.13:2888:3888
```
2. replaced entry in /opt/kafka/config/**server.properties**  
replaced
``` 
   zookeeper.connect=localhost
```
with
```
   zookeeper.connect=192.168.50.11:2181,192.168.50.12:2181,192.168.50.13:2181
```
