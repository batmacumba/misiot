ruby mqtt.rb 20 &
TEST=$!
sleep 5 && ps aux --sort=-pcpu > ps/MQTT
wait $TEST