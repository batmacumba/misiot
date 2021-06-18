require 'httparty'
require 'rubygems'
require 'mqtt'
require 'descriptive_statistics'
require "active_support/all"

N_VALORES = 1000
N_ENSAIOS = 1

def register_new_resource()
	# Criação de um novo resource
	response = HTTParty.post('http://127.0.0.1:3003/resources/', 
		:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
		:body => {
				  "data": {
				    "description": "Sensor",
				    "capabilities": [
				      "temperature",
				    ],
				    "status": "active",
				    "lat": -23.559616,
				    "lon": -46.731386
				  }
				}.to_json)

	# Handling da resposta
	if response.code != 201
		puts "Não foi possível criar um novo resource"
		return
	end
	uuid = JSON.parse(response.body)['data']['uuid']
	return uuid
end

def send_all_values(uuid, message)
	# Envio dos valores
	MQTT::Client.connect('localhost') do |c|
		N_VALORES.times {
			c.publish('resources/' + uuid, message)
		}
	end
end

def main()
	# Variáveis globais
	elapsed_time = Array.new(N_ENSAIOS, 0)
	start_time = Array.new(N_ENSAIOS, 0)
	message = {
				  "data": {
				    "environment_monitoring": [
				      {
				        "temperature": 10,
				        "timestamp": "2017-06-14T17:52:25.428Z"
				      }
				    ]
				  }
				}.to_json

	# Criação dos novos resources
	uuids = []
	N_THREADS.times {
	    uuids << register_new_resource()
	}
	puts uuids

	# Envio dos valores
	N_ENSAIOS.times do |ens_i| 
		begin
			threads = []

			start_time[ens_i] = Time.now
			N_THREADS.times do |thr_i|
			    threads << Thread.new { send_all_values(uuids[thr_i], message) }
			end
			threads.each { |thr| thr.join }
			elapsed_time[ens_i] = (Time.now - start_time[ens_i]).round(3)
		rescue
			retry
		end
	end
end

if ARGV.length < 1
  puts "Too few arguments"
  exit
end
N_THREADS = ARGV[0].to_i

main()