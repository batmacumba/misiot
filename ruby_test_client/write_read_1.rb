require 'paho-mqtt'

start_time = 0
message_counter = 0
elapsed_times = []
waiting_message = true
waiting_suback = true
waiting_puback = true

client = PahoMqtt::Client.new

client.on_message do |message|
	elapsed_time = Time.now - start_time
	message_counter += 1
	elapsed_times << elapsed_time
	waiting_message = false
end

### Register a callback on suback to assert the subcription
client.on_suback do
  waiting_suback = false
end

### Register a callback for puback event when receiving a puback
client.on_puback do
  waiting_puback = false
end

# Connect to the eclipse test server on port 1883 (Unencrypted mode)
client.connect('127.0.0.1', 1883)

### Subscribe to a topic
client.subscribe(['/mqtt/teste', 2])

### Waiting for the suback answer and excute the previously set on_suback callback
while waiting_suback do
  sleep 0.001
end

while message_counter < 1000 do
	waiting_message = true
	start_time = Time.now
	# Publlish a message on the topic "/paho/ruby/test" with "retain == false" and "qos == 1"
	client.publish("/mqtt/teste", "1", false, 1)
	while waiting_message do
	  nil
	end
end

i = 0
while i < 1000 do
	elapsed_in_ms = (elapsed_times[i] * 1000).round(3)
	print "#{elapsed_in_ms}\n"
	i += 1
end

# average_time = ((elapsed_times.inject(0){|sum,x| sum + x } / elapsed_times.size) * 1000).round(3)
# print "sample size: #{elapsed_times.size}\n"
# print "average ms for message arrival: #{average_time}\n"

### Calling an explicit disconnect
client.disconnect