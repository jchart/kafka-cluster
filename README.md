# Apache Kafka cluster setup 
This project creates a three node [Apache Kafaka](https://kafka.apache.org) cluster on a Vagrant provisioned Centos 7 VM. 

# Prerequisites
* Download and Install <a href="https://www.virtualbox.org/wiki/Downloads" target="_blank">Virtual Box</a>
* Download and Install <a href="https://www.vagrantup.com/downloads.html" target="_blank">Vagrant</a>
* Windows users download and Install <a href="https://git-scm.com/downloads" target="_blank">Git Bash</a>   
    when prompted:
      * Select 'Use Git from Git Bash Only'   
      * Select 'Check out as-is, commit as-is'

```ShellSession
git clone https://github.com/PaulSRusso/kafka-cluster.git
cd kafka-cluster
vagrant up
```

A private network is created   
node-1 | 192.168.50.11 | 9091  
node-2 | 192.168.50.12 | 9092   
node-3 | 192.168.50.13 | 9093   

### Testing the system...

### Open three terminals 

### Create a topic in node-1
```ShellSession
vagrant ssh node-1
[vagrant@node-1:~] create-topic.sh topic1
```

### Produce a message in node-2
```ShellSession
vagrant ssh node-2
[vagrant@node-2:~] producer.sh topic1
Hello Kafka 
[ctrl-c]
```

### Recieve the message in node-3
```ShellSession
vagrant ssh node-3
[vagrant@node-3:~] consumer.sh topic1
Hello Kafka 
[ctrl-c]
```

### Recieve the same message in the other two nodes
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
