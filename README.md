# Apache Kafka cluster setup 
This project creates a three node [Apache Kafaka](https://kafka.apache.org) cluster on a Vagrant provisioned Centos 7 VM. 


```ShellSession
git clone https://github.com/PaulSRusso/kafka-cluster.git
cd kafka-cluster
vagrant up
```

A private network is created   
host | ip | exposed port   
---|---|---   
node-1 | 192.168.50.11 | 9091  
node-2 | 192.168.50.12 | 9092   
node-3 | 192.168.50.13 | 9093   

## Test the system

### Open three terminals 

### Create a topic in node-1
```ShellSession
vagrant ssh node-1
[vagrant@node-1:~] create-topic.sh topic1
```

## Produce a message in node-2
```ShellSession
vagrant ssh node-2
[vagrant@node-2:~] producer.sh topic1
Hello Kafka 
[ctrl-c]
```

## Recieve the message in node-3
```ShellSession
vagrant ssh node-3
[vagrant@node-3:~] consumer.sh topic1
Hello Kafka 
[ctrl-c]
```

## Recieve the same message in the other two nodes
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
