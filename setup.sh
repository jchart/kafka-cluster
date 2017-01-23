#!/bin/bash
SERVER_NUM=$1

# set environment
. /vagrant/.bashrc
cp /vagrant/.bashrc /home/vagrant
cp /vagrant/.bashrc /root
# every broker has a unique id
sed -i "s/broker.id=0/broker.id=$SERVER_NUM/" /opt/kafka/config/server.properties 

# set timeout to 10 minutes - allow other servers to start
sed -i "s/zookeeper.connection.timeout.ms=6000/zookeeper.connection.timeout.ms=600000/" /opt/kafka/config/server.properties 

# create dir; serverid -> myid 
mkdir /tmp/zookeeper
echo $SERVER_NUM > /tmp/zookeeper/myid

# start zookeeper
/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties > /tmp/zookeeper.log &

# start Kafka
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties > /tmp/kafka.log &
