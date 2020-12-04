#!/bin/bash
INFRA=25861
ACTUATOR=24861
DATA=24895
ADAPTOR=24968
SIDEKIQ=25217
CATALOGUER=
DISCOVERER=

ruby http.rb &
P0=$!   
psrecord $INFRA --interval 1 --duration 60 --plot INFRA.png &
P1=$!
psrecord $ACTUATOR --interval 1 --duration 60 --plot ACTUATOR.png &
P2=$!
psrecord $DATA --interval 1 --duration 60 --plot DATA.png &
P3=$!
psrecord $ADAPTOR --interval 1 --duration 60 --plot ADAPTOR.png &
P4=$!
psrecord $SIDEKIQ --interval 1 --duration 60 --plot SIDEKIQ.png &
P5=$!
psrecord $CATALOGUER --interval 1 --duration 60 --plot CATALOGUER.png &
P6=$!
psrecord $DISCOVERER --interval 1 --duration 60 --plot DISCOVERER.png &
P7=$!
wait $P1 $P2 $P3 $P4 $P5 $P6 $P7
kill $P0
echo 'Done'
