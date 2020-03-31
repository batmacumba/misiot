require 'paho-mqtt'

# starting = Time.now
# # time consuming operation
# ending = Time.now
# elapsed = ending - starting
# puts elapsed
# Variáveis usadas em ambos os clientes
starting = 0
ending = 0
message_counter = 0


pub_client = PahoMqtt::Client.new
sub_client = PahoMqtt::Client.new

# Callback para o cliente que escuta

sub_client.on_message do |message|
	elapsed = Time.now - starting
	puts "#{message.topic}: #{message.payload}"
	puts "elapsed time: #{elapsed}"
	message_counter += 1
end

# ### Register a callback on suback to assert the subcription
# waiting_suback = true
# client.on_suback do
#   waiting_suback = false
#   puts "Subscribed"
# end

# ### Register a callback for puback event when receiving a puback
# waiting_puback = true
# client.on_puback do
#   waiting_puback = false
#   puts "Message Acknowledged"
# end

### Connect to the eclipse test server on port 1883 (Unencrypted mode)
client.connect('127.0.0.1', 1883)

### Subscribe to a topic
client.subscribe(['/mqtt/teste', 2])

### Waiting for the suback answer and excute the previously set on_suback callback
while waiting_suback do
  sleep 0.001
end

### Publlish a message on the topic "/paho/ruby/test" with "retain == false" and "qos == 1"
starting = Time.now
client.publish("/mqtt/teste", "1", false, 1)

while waiting_puback do
  sleep 0.001
end

### Waiting to assert that the message is displayed by on_message callback
sleep 1

### Calling an explicit disconnect
client.disconnect