require 'paho-mqtt'
require 'httparty'
require 'descriptive_statistics'
require_relative 'mqtt_client'

def print_results(n, clients, length, address, ssl, cert, key, port, topic, elapsed_times)
	print "------------------------------------------------------------\n"
    print "Number of Clients:\t\t#{n}\n"
    print "#{mode} time min:  \t\t#{elapsed_times.min()} ms\n"
    print "#{mode} time max:  \t\t#{elapsed_times.max()} ms\n"
    print "#{mode} time mean: \t\t#{elapsed_times.mean().round(3)} ms\n"
    print "#{mode} time std:  \t\t#{elapsed_times.standard_deviation().round(3)} ms\n"
    print "------------------------------------------------------------\n"
end

# args = Hash[ ARGV.join(' ').scan(/--?([^=\s]+)(?:=(\S+))?/) ]
# args['clients'].nil? ? n = 1 : n = args['clients'].to_i
# args['length'].nil? ? length = 1 : length = args['length'].to_i
# args['address'].nil? ? address = '127.0.0.1' : address = args['address']
# args['cert'].nil? ? cert = nil : cert = args['cert']
# args['key'].nil? ? key = nil : key = args['key']
# ssl = !(cert.nil? || key.nil?)
# port = args['port']

# threads = []
# clients = []
# elapsed_times = []
# lock = Mutex.new

# n.times {
# 		clients << MQTTClient.new(clients,
# 							  length,
# 							  address,
# 							  ssl,
# 							  cert,
# 							  key,
# 							  port,
# 							  topic,
# 							  elapsed_times,
# 							  lock,
# 							  false)
# }
# # Sequential execution
# if mode == "r" || mode == "w"
# 	clients.each do |client|
# 		client.run()
# 	end
# end

# 	start_time = []
# 	publisher_lock = Mutex.new
# 	publisher = Client.new(clients,
# 				    	'w',
# 				    	length,
# 				    	address,
# 				    	ssl,
# 				    	cert,
# 				    	key,
# 				    	port,
# 				    	topic,
# 				    	start_time,
# 				   		publisher_lock,
# 				   		true)
# 	publisher.run()
# 	threads.each(&:join)

# 	elapsed_times.each_with_index do |t, i|
# 		elapsed_times[i] = ((t - start_time[0]) * 1000).round(3)
# 	end

# end

# print_results(n,
# 			  clients,
# 			  length,
# 			  address,
# 			  ssl,
# 			  cert,
# 			  key,
# 			  port,
# 			  topic,
# 			  elapsed_times)