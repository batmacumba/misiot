require 'httparty'
require 'socket'
require 'descriptive_statistics'
require "active_support/all"

N_VALORES = 100
N_ENSAIOS = 30

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
	N_VALORES.times {
		HTTParty.post('http://127.0.0.1:3002/resources/' + uuid + '/data', 
			:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
			:body => message)
	}
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


	total_valores = N_VALORES * N_THREADS
	# Escrita dos dados gerados
	f = File.open("http/" + N_THREADS.to_s + "/DATA", "w")
	for time in elapsed_time
		f.write("#{(total_valores / time).round(2)}\n") 
	end

	f = File.open("http/" + N_THREADS.to_s + "/STATS", "w")
	str = ""
	str += "------------------------------------------------------------\n"
	str += "min:  \t\t#{(total_valores / elapsed_time.max()).round(2)} msg/s\n"
	str += "max:  \t\t#{(total_valores / elapsed_time.min()).round(2)} msg/s\n"
	str += "mean: \t\t#{(total_valores / elapsed_time.mean()).round(2)} msg/s\n"
	str += "------------------------------------------------------------\n"

	f.write(str)
	print(str)
end

if ARGV.length < 1
  puts "Too few arguments"
  exit
end
N_THREADS = ARGV[0].to_i

main()