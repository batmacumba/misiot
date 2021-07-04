#!/bin/bash
INTERVAL=1
DURATION=60

RABBITMQ=$(docker inspect -f '{{.State.Pid}}' $(docker ps | grep 'rabbitmq' | awk '{ print $1 }'))
ACTUATOR=$(pm2 -m ls | grep "+\-\-\- actuator" -A 3 | grep pid | grep -oP '\d+$')
DATA=$(pm2 -m ls | grep "+\-\-\- data" -A 3 | grep pid | grep -oP '\d+$')
ADAPTOR=$(pm2 -m ls | grep "^+\-\-\- resource-adaptor$" -A 3 | grep pid | grep -oP '\d+$')
SIDEKIQ=$(pm2 -m ls | grep "+\-\-\- resource-adaptor-sidekiq" -A 3 | grep pid | grep -oP '\d+$')
CATALOGUER=$(pm2 -m ls | grep "+\-\-\- resource-cataloguer" -A 3 | grep pid | grep -oP '\d+$')
DISCOVERER=$(pm2 -m ls | grep "+\-\-\- resource-discoverer" -A 3 | grep pid | grep -oP '\d+$')
MOSQUITTO=$(pgrep mosquitto)


ruby http.rb 40 &
P0=$!   
psrecord $RABBITMQ --interval $INTERVAL --duration $DURATION --log http/RABBITMQ --include-children &
P1=$!
psrecord $ACTUATOR --interval $INTERVAL --duration $DURATION --log http/ACTUATOR --include-children &
P2=$!
psrecord $DATA --interval $INTERVAL --duration $DURATION --log http/DATA --include-children &
P3=$!
psrecord $ADAPTOR --interval $INTERVAL --duration $DURATION --log http/ADAPTOR --include-children &
P4=$!
psrecord $SIDEKIQ --interval $INTERVAL --duration $DURATION --log http/SIDEKIQ --include-children &
P5=$!
psrecord $CATALOGUER --interval $INTERVAL --duration $DURATION --log http/CATALOGUER --include-children &
P6=$!
psrecord $DISCOVERER --interval $INTERVAL --duration $DURATION --log http/DISCOVERER --include-children &
P7=$!
psrecord $MOSQUITTO --interval $INTERVAL --duration $DURATION --log http/MOSQUITTO --include-children &
P8=$!
wait $P1 $P2 $P3 $P4 $P5 $P6 $P7 $P8
kill $P0
echo 'Done'
