#!/bin/bash
INTERVAL=1
DURATION=60
RABBITMQ=606
ACTUATOR=8368
DATA=8419
ADAPTOR=8550
SIDEKIQ=8602
CATALOGUER=8651
DISCOVERER=8709

ruby mqtt.rb &
P0=$!   
psrecord $RABBITMQ --interval $INTERVAL --duration $DURATION --plot mqtt/RABBITMQ.png &
P1=$!
psrecord $ACTUATOR --interval $INTERVAL --duration $DURATION --plot mqtt/ACTUATOR.png &
P2=$!
psrecord $DATA --interval $INTERVAL --duration $DURATION --plot mqtt/DATA.png &
P3=$!
psrecord $ADAPTOR --interval $INTERVAL --duration $DURATION --plot mqtt/ADAPTOR.png &
P4=$!
psrecord $SIDEKIQ --interval $INTERVAL --duration $DURATION --plot mqtt/SIDEKIQ.png &
P5=$!
psrecord $CATALOGUER --interval $INTERVAL --duration $DURATION --plot mqtt/CATALOGUER.png &
P6=$!
psrecord $DISCOVERER --interval $INTERVAL --duration $DURATION --plot mqtt/DISCOVERER.png &
P7=$!
wait $P1 $P2 $P3 $P4 $P5 $P6 $P7
kill $P0
echo 'Done'
