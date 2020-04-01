require 'paho-mqtt'

start_time = 0
ack_counter = 0
waiting_puback = true
elapsed_times = []

client = PahoMqtt::Client.new

# Callback para a mensagem puback
client.on_puback do
  elapsed_time = Time.now - start_time
  # puts "message #{ack_counter}: #{elapsed_time}"
  ack_counter += 1
  elapsed_times << elapsed_time
  waiting_puback = false
end

# Connect to the eclipse test server on port 1883 (Unencrypted mode)
client.connect('127.0.0.1', 1883)

while ack_counter < 1000 do
	waiting_puback = true
	start_time = Time.now
	# Publlish a message on the topic "/paho/ruby/test" with "retain == false" and "qos == 1"
	client.publish("/mqtt/teste", "1", false, 1)
	while waiting_puback do
		sleep(0.001)
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
# print "average ms for puback: #{average_time}\n"

### Calling an explicit disconnect
client.disconnect