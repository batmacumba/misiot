echo "Iniciando Mosquitto..."
brew services restart mosquitto
echo "Iniciando Aedes..."
cd brokers/aedes/
pm2 start simple.js
pm2 start ssl.js
echo "Iniciando HiveMQ..."
cd ../hivemq
pm2 start ./bin/run.sh 



