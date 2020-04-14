
mkdir resultados
mkdir resultados/mosquitto
mkdir resultados/aedes
mkdir resultados/hivemq

echo "Iniciando Mosquitto..."
brew services restart mosquitto
echo "Iniciando Aedes..."
cd brokers/aedes/
pm2 start simple.js
pm2 start ssl.js
echo "Iniciando HiveMQ..."
cd ../hivemq
pm2 start ./bin/run.sh 

cd ../../../
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1 --port=1883 > ./broker_benchmark/resultados/mosquitto/01_plain_write_1
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1000 --port=1883 > ./broker_benchmark/resultados/mosquitto/02_plain_write_1000
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1 --port=1883 > ./broker_benchmark/resultados/mosquitto/03_plain_read_1
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1000 --port=1883 > ./broker_benchmark/resultados/mosquitto/04_plain_read_1000
ruby mqttperf/mqttperf.rb --mode=s --clients=10 --length=1000 --port=1883 > ./broker_benchmark/resultados/mosquitto/05_plain_spread_10
ruby mqttperf/mqttperf.rb --mode=s --clients=50 --length=1000 --port=1883 > ./broker_benchmark/resultados/mosquitto/06_plain_spread_50
ruby mqttperf/mqttperf.rb --mode=s --clients=100 --length=1000 --port=1883 > ./broker_benchmark/resultados/mosquitto/07_plain_spread_100
ruby mqttperf/mqttperf.rb --mode=s --clients=200 --length=1000 --port=1883 > ./broker_benchmark/resultados/mosquitto/08_plain_spread_200
echo "mosquitto: testes plain completos"
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/mosquitto/09_ssl_write_1
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/mosquitto/10_ssl_write_1000
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/mosquitto/11_ssl_read_1
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/mosquitto/12_ssl_read_1000
ruby mqttperf/mqttperf.rb --mode=s --clients=10 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/mosquitto/13_ssl_spread_10
ruby mqttperf/mqttperf.rb --mode=s --clients=50 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/mosquitto/14_ssl_spread_50
ruby mqttperf/mqttperf.rb --mode=s --clients=100 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/mosquitto/15_ssl_spread_100
ruby mqttperf/mqttperf.rb --mode=s --clients=200 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/mosquitto/16_ssl_spread_200
echo "mosquitto: testes ssl completos"


ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1 --port=1884 > ./broker_benchmark/resultados/aedes/01_plain_write_1
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1000 --port=1884 > ./broker_benchmark/resultados/aedes/02_plain_write_1000
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1 --port=1884 > ./broker_benchmark/resultados/aedes/03_plain_read_1
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1000 --port=1884 > ./broker_benchmark/resultados/aedes/04_plain_read_1000
ruby mqttperf/mqttperf.rb --mode=s --clients=10 --length=1000 --port=1884 > ./broker_benchmark/resultados/aedes/05_plain_spread_10
ruby mqttperf/mqttperf.rb --mode=s --clients=50 --length=1000 --port=1884 > ./broker_benchmark/resultados/aedes/06_plain_spread_50
ruby mqttperf/mqttperf.rb --mode=s --clients=100 --length=1000 --port=1884 > ./broker_benchmark/resultados/aedes/07_plain_spread_100
ruby mqttperf/mqttperf.rb --mode=s --clients=200 --length=1000 --port=1884 > ./broker_benchmark/resultados/aedes/08_plain_spread_200
echo "aedes: testes plain completos"
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/aedes/09_ssl_write_1
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/aedes/10_ssl_write_1000
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/aedes/11_ssl_read_1
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/aedes/12_ssl_read_1000
ruby mqttperf/mqttperf.rb --mode=s --clients=10 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/aedes/13_ssl_spread_10
ruby mqttperf/mqttperf.rb --mode=s --clients=50 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/aedes/14_ssl_spread_50
ruby mqttperf/mqttperf.rb --mode=s --clients=100 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/aedes/15_ssl_spread_100
ruby mqttperf/mqttperf.rb --mode=s --clients=200 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/aedes/16_ssl_spread_200
echo "aedes: testes ssl completos"

ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1 --port=1885 > ./broker_benchmark/resultados/hivemq/01_plain_write_1
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1000 --port=1885 > ./broker_benchmark/resultados/hivemq/02_plain_write_1000
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1 --port=1885 > ./broker_benchmark/resultados/hivemq/03_plain_read_1
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1000 --port=1885 > ./broker_benchmark/resultados/hivemq/04_plain_read_1000
ruby mqttperf/mqttperf.rb --mode=s --clients=10 --length=1000 --port=1885 > ./broker_benchmark/resultados/hivemq/05_plain_spread_10
ruby mqttperf/mqttperf.rb --mode=s --clients=50 --length=1000 --port=1885 > ./broker_benchmark/resultados/hivemq/06_plain_spread_50
ruby mqttperf/mqttperf.rb --mode=s --clients=100 --length=1000 --port=1885 > ./broker_benchmark/resultados/hivemq/07_plain_spread_100
ruby mqttperf/mqttperf.rb --mode=s --clients=200 --length=1000 --port=1885 > ./broker_benchmark/resultados/hivemq/08_plain_spread_200
echo "hivemq: testes plain completos"
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/hivemq/09_ssl_write_1
ruby mqttperf/mqttperf.rb --mode=w --clients=1000 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/hivemq/10_ssl_write_1000
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/hivemq/11_ssl_read_1
ruby mqttperf/mqttperf.rb --mode=r --clients=1000 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/hivemq/12_ssl_read_1000
ruby mqttperf/mqttperf.rb --mode=s --clients=10 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/hivemq/13_ssl_spread_10
ruby mqttperf/mqttperf.rb --mode=s --clients=50 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/hivemq/14_ssl_spread_50
ruby mqttperf/mqttperf.rb --mode=s --clients=100 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/hivemq/15_ssl_spread_100
ruby mqttperf/mqttperf.rb --mode=s --clients=200 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/hivemq/16_ssl_spread_200
echo "hivemq: testes ssl completos"


echo "Parando Mosquitto..."
brew services stop mosquitto
echo "Parando Aedes..."
pm2 stop simple
pm2 stop ssl
echo "Parando HiveMQ..."
pm2 stop run