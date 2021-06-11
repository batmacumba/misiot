require 'rubygems'
require 'mqtt'
require 'json'

payload = 
{
    "data": [
        {
            "temperature": 10,
            "timestamp": "2017-06-14T17:52:25.428Z"
        }
    ]
}.to_json

MQTT::Client.connect('127.0.0.1') do |c|
  c.publish('resources/0c350791-4971-46a0-8b00-9034df38a36c/temperature', payload)
end
