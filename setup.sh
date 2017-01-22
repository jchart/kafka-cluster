#!/bin/bash
echo "#prompt colors and style" >> .bashrc
echo "export PS1='\[\e[33m\][\u@\h:\[\e[1;34m\]\W\[\e[m\]] '" >> .bashrc
echo "export JAVA_HOME=/opt/jdk" >> .bashrc
echo "export PATH=$PATH:$JAVA_HOME/bin" >> .bashrc
echo "#prompt colors and style" >> /root/.bashrc
echo "export PS1='\[\e[33m\][\u@\h:\[\e[1;34m\]\W\[\e[m\]] '" >> /root/.bashrc
echo "export JAVA_HOME=/opt/jdk" >> /root/.bashrc
echo "export PATH=$PATH:$JAVA_HOME/bin" >> /root/.bashrc
 
export JAVA_HOME=/opt/jdk
export PATH=$PATH:$JAVA_HOME/bin
SERVER_NUM=$1
sed -i "s/broker.id=0/broker.id=$SERVER_NUM/" /opt/kafka/config/server.properties 
# set timeout to 10 minutes
sed -i "s/zookeeper.connection.timeout.ms=6000/zookeeper.connection.timeout.ms=600000/" /opt/kafka/config/server.properties 

echo $SERVER_NUM > /tmp/zookeeper/myid
/vagrant/bin/start-zookeeper.sh
/vagrant/bin/start-kafka.sh

