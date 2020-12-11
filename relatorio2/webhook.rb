require 'socket'

server = TCPServer.new 5678
while session = server.accept
  	body = "Ok"
	head = "HTTP/1.1 200\r\n" \
	"Date: #{Time.now}\r\n" \
	"Content-Length: #{body.length.to_s}\r\n" 

	session.write head
	session.write "\r\n"
	session.write body
	session.close
end