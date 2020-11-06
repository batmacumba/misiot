require 'httparty'
require 'paho-mqtt'

N = 1000
# Criação de um novo resource
response = HTTParty.post('http://127.0.0.1:3003/resources/', 
	:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
	:body => {
			  "data": {
			    "description": "Atuador",
			    "capabilities": [
			      "illuminate",
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

# Abre o cliente MQTT
client = PahoMqtt::Client.new()
client.connect('127.0.0.1', 1883)
client.subscribe(['commands/' + uuid, 2])
while @waiting_suback do
	sleep 0.001
end

start_time = 0
elapsed_time = 0
waiting_for_command = false

client.on_message do |message|
	elapsed_time = ((Time.now - start_time) * 1000).round(3)
	waiting_for_command = false
end

# Envio das N mensagens
N.times {
	HTTParty.post('http://127.0.0.1:3000/commands', 
		:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
		:body => {
				  "data": [
				    {
				      "uuid": "#{uuid}",
				      "capabilities": {
				        "illuminate": "on"
				      }
				    }
				  ]
				}.to_json)
	start_time = Time.now()
	waiting_for_command = true
	while waiting_for_command
		nil
	end
	print("#{elapsed_time}\n")
}

