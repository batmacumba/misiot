require 'httparty'
require 'socket'
require 'descriptive_statistics'

N = 1
N_observacoes = 17280 # simula uma observação a cada 5s durante um dia

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
puts uuid
# Variáveis globais
elapsed_time = Array.new(N, 0)
start_time = Array.new(N, 0)
i = 0

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
# Thread que enviará os valores à plataforma
N.times {
	start_time[i] = Time.now()
	N_observacoes.times {
		HTTParty.post('http://127.0.0.1:3002/resources/' + uuid + '/data', 
			:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
			:body => message)
	}
	elapsed_time[i] = ((Time.now - start_time[i]) * 1000).round(3)
	i += 1
	print("Ensaio #{i}\n")
}


# Escrita dos dados gerados
f = File.open("http/DATA", "w")
for time in elapsed_time
	f.write("#{time}\n") 
end

f = File.open("http/STATS", "w")
str = ""
str += "------------------------------------------------------------\n"
str += "min:  \t\t#{elapsed_time.min()} ms\n"
str += "max:  \t\t#{elapsed_time.max()} ms\n"
str += "mean: \t\t#{elapsed_time.mean().round(3)} ms\n"
str += "std:  \t\t#{elapsed_time.standard_deviation().round(3)} ms\n"
str += "------------------------------------------------------------\n"

f.write(str)
print(str)