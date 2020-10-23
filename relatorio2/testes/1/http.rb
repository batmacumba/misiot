require 'httparty'

response = HTTParty.post('http://127.0.0.1:3002/resources/0c350791-4971-46a0-8b00-9034df38a36c/data/temperature', 
	:headers => {'cache-control': 'no-cache','content-type': 'application/json'}, 
	:body => {
				"data": [
					{
						"temperature": 10,
						"timestamp": "2017-06-14T17:52:25.428Z"
					}
				]
				}.to_json)

puts response.code, response.body