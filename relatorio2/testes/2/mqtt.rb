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

# Variáveis globais
elapsed_time = Array.new(1000, 0)
start_time = Array.new(1000, 0)
i = 0
waiting_for_reply = false

# Cliente MQTT que receberá os comandos da plataforma
client = PahoMqtt::Client.new
client.connect('127.0.0.1', 1883, client.keep_alive, true, client.blocking)
client.subscribe(['commands/' + uuid, 2])
client.on_message do |message|
	waiting_for_reply = false
end


# Envio dos comandos à plataforma
N.times {
	start_time[i] = Time.now()
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
	waiting_for_reply = true
	while waiting_for_reply
		nil
	end
	elapsed_time[i] = ((Time.now - start_time[i]) * 1000).round(3)
	print("#{elapsed_time[i]}\n")
	i += 1
}