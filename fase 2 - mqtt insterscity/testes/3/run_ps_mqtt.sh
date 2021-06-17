ruby mqtt.rb 100 &
TEST=$!
sleep 5 && ps aux --sort=-pcpu > ps/MQTT
wait $TEST