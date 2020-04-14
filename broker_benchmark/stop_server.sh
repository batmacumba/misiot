echo "Parando Mosquitto..."
brew services stop mosquitto
echo "Parando Aedes..."
pm2 stop simple
pm2 stop ssl
echo "Parando HiveMQ..."
pm2 stop run
