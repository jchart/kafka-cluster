#/bin/bash
/opt/kafka/bin/kafka-console-producer.sh --topic "$1" --broker-list 192.168.50.11:9092,192.168.50.12:9092,192.168.50.13:9092
