ruby mqtt.rb &
TEST=$!
sleep 5 && ps aux --sort=-pcpu > ps/MQTT
wait $TEST