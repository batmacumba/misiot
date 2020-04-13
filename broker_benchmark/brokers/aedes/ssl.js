const fs = require('fs')
const path = require('path'); 
const aedes = require('aedes')()
const port = 8884

const options = {
  key: fs.readFileSync(path.join(__dirname, '../../keys/mqtt.server/key.pem')),
  cert: fs.readFileSync(path.join(__dirname, '../../keys/mqtt.server/cert.pem'))
}

const server = require('tls').createServer(options, aedes.handle)

server.listen(port, function () {
  console.log('server started and listening on port ', port)
})