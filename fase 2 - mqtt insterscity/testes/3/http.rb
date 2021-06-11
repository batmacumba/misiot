require 'httparty'
require 'socket'
require 'descriptive_statistics'
require "active_support/all"

N_valores = 100
N_threads = 100
N_ensaios = 100

def HTTP_Sensor()
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

	# Envio dos valores
	N_valores.times {
		HTTParty.post('http://127.0.0.1:3002/resources/' + uuid + '/data', 
			:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
			:body => message)
	}
end

# Variáveis globais
elapsed_time = Array.new(N_ensaios, 0)
start_time = Array.new(N_ensaios, 0)
i = 0

N_ensaios.times {
	start_time[i] = Time.now

	threads = []
	N_threads.times {
	    threads << Thread.new { HTTP_Sensor() }
	}
	threads.each { |thr| thr.join }

	elapsed_time[i] = (Time.now - start_time[i]).round(3)
	i += 1
}


total_valores = N_valores * N_threads
# Escrita dos dados gerados
f = File.open("http/DATA", "w")
for time in elapsed_time
	f.write("#{(total_valores / time).round(2)}\n") 
end

f = File.open("http/STATS", "w")
str = ""
str += "------------------------------------------------------------\n"
str += "min:  \t\t#{(total_valores / elapsed_time.max()).round(2)} msg/s\n"
str += "max:  \t\t#{(total_valores / elapsed_time.min()).round(2)} msg/s\n"
str += "mean: \t\t#{(total_valores / elapsed_time.mean()).round(2)} msg/s\n"
str += "------------------------------------------------------------\n"

f.write(str)
print(str)