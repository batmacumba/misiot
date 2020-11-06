require 'httparty'
require 'socket'

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


# Criação de uma nova subscription
response = HTTParty.post('http://127.0.0.1:3002/subscriptions', 
	:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
	:body => {
			  "subscription": {
			    "uuid": "#{uuid}",
			    "capabilities": [
			      "illuminate"
			    ],
			    "url": "http://localhost:5678"
			  }
			}.to_json)

# Handling da resposta
if response.code != 201
	puts "Não foi possível criar uma nova subscription"
	return
end

# Criação do Webhook
server = TCPServer.new 5678
waiting_for_command = false
elapsed_time = 0
start_time = 0

t = Thread.new {
	while session = server.accept
	  elapsed_time = ((Time.now - start_time) * 1000).round(3)
	  	body = "Ok"
		head = "HTTP/1.1 200\r\n" \
		"Date: #{Time.now.httpdate}\r\n" \
		"Content-Length: #{body.length.to_s}\r\n" 

		session.write head
		session.write "\r\n"
		session.write body
		session.close
	  waiting_for_command = false
	end
}

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

t.join