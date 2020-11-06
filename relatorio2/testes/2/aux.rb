require 'httparty'

# response = HTTParty.post('http://127.0.0.1:3003/resources/', 
# 	:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
# 	:body => {
# 			  "data": {
# 			    "description": "Atuador",
# 			    "capabilities": [
# 			      "illuminate",
# 			    ],
# 			    "status": "active",
# 			    "lat": -23.559616,
# 			    "lon": -46.731386
# 			  }
# 			}.to_json)

# response = HTTParty.post('http://127.0.0.1:3003/capabilities', 
# 	:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
# 	:body => {
# 				"name": "temperature",
# 				"description": "Measure the temperature of the environment",
# 				"capability_type": "sensor"
# 			}.to_json)

# response = HTTParty.post('http://127.0.0.1:3002/subscriptions', 
# 	:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
# 	:body => {
# 			  "subscription": {
# 			    "uuid": "a0ca535f-dca7-4839-9a46-e8a019cc1494",
# 			    "capabilities": [
# 			      "illuminate"
# 			    ],
# 			    "url": "http://localhost:5678"
# 			  }
# 			}.to_json)



# puts response.code, response.body