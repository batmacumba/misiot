require 'paho-mqtt'

args = Hash[ ARGV.join(' ').scan(/--?([^=\s]+)(?:=(\S+))?/) ]
n = args['n'].to_i

message_counter = 0
subscribers = []
publisher = PahoMqtt::Client.new

# String aleatória
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
string = (0...1000).map { o[rand(o.length)] }.join

i = 0
while i < n do
	subscribers[i] = PahoMqtt::Client.new
	subscribers[i].on_message do |message|
		message_counter += 1
	end
	subscribers[i].connect('127.0.0.1', 1883)
	subscribers[i].subscribe(['/mqtt/teste', 2])
	i += 1
end

# Connect to the eclipse test server on port 1883 (Unencrypted mode)
publisher.connect('127.0.0.1', 1883)

start_time = Time.now
# Publlish a message on the topic "/paho/ruby/test" with "retain == false" and "qos == 1"
publisher.publish("/mqtt/teste", string, false, 1)

while message_counter < n do
	nil
end

elapsed_time = ((Time.now - start_time) * 1000).round(3)
print "#{elapsed_time}\n"
# print "elapsed time in ms: #{elapsed_time}\n"
# print "message_counter: #{message_counter}\n"

# Calling an explicit disconnect
publisher.disconnect
i = 0
while i < n do
	subscribers[i].disconnect
	i += 1
end