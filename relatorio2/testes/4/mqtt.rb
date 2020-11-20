require 'httparty'
require 'paho-mqtt'
require 'descriptive_statistics'

# Uma observação a cada 5s durante um dia inteiro
observacoes = 17280
N = 1000

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

# message = " {
# 			\"data\": {
# 				\"environment_monitoring\": ["

# for i in 0..observacoes
# 	now = Time.now.utc + (i * 5)
# 	message += "{
# 				 	\"temperature\": #{rand(15..40)},
# 				 	\"timestamp\": \"2017-06-14T17:52:25.428Z#{now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')}\"
# 				},"
# end

# message += "]}}"

client = PahoMqtt::Client.new
# Envio dos valores à plataforma
for i in 0..N
	start_time[i] = Time.now()
	client.connect('127.0.0.1', 1883)
	client.publish('teste/' + uuid, "message")
	elapsed_time[i] = ((Time.now - start_time[i]) * 1000).round(3)
	client.disconnect()
	i += 1
end

# Escrita dos dados gerados
f = File.open("mqtt/DATA", "w")
for time in elapsed_time
	f.write("#{time}\n") 
end

f = File.open("mqtt/STATS", "w")
str = ""
str += "------------------------------------------------------------\n"
str += "min:  \t\t#{elapsed_time.min()} ms\n"
str += "max:  \t\t#{elapsed_time.max()} ms\n"
str += "mean: \t\t#{elapsed_time.mean().round(3)} ms\n"
str += "std:  \t\t#{elapsed_time.standard_deviation().round(3)} ms\n"
str += "------------------------------------------------------------\n"

f.write(str)
print(str)