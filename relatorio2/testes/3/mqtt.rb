require 'httparty'
require 'paho-mqtt'
require 'descriptive_statistics'

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

# Variáveis globais
elapsed_time = Array.new(1000, 0)
start_time = Array.new(1000, 0)
i = 0

# Cliente MQTT que receberá os comandos da plataforma
client = PahoMqtt::Client.new

message = " {
			\"data\": {
				\"environment_monitoring\": [
					{
						\"temperature\": 10,
						\"timestamp\": \"2017-06-14T17:52:25.428Z\"
					}
				]
				}
			}"

# Envio dos comandos à plataforma
N.times {
	start_time[i] = Time.now()
	client.connect('127.0.0.1', 1883)
	client.publish('resources/' + uuid, message)
	elapsed_time[i] = ((Time.now - start_time[i]) * 1000).round(3)
	client.disconnect()
	i += 1
}

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