IP_Address=$1
prefix="${IP_Address:0:3}"

mkdir resultados_${prefix}
mkdir resultados_${prefix}/mosquitto
mkdir resultados_${prefix}/aedes
mkdir resultados_${prefix}/hivemq

cd ..
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=10 --length=1000 --port=1883 > ./broker_benchmark/resultados_${prefix}/mosquitto/05_plain_spread_10
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=50 --length=1000 --port=1883 > ./broker_benchmark/resultados_${prefix}/mosquitto/06_plain_spread_50
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=100 --length=1000 --port=1883 > ./broker_benchmark/resultados_${prefix}/mosquitto/07_plain_spread_100
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=200 --length=1000 --port=1883 > ./broker_benchmark/resultados_${prefix}/mosquitto/08_plain_spread_200
echo "mosquitto: testes plain completos"
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=10 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/mosquitto/13_ssl_spread_10
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=50 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/mosquitto/14_ssl_spread_50
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=100 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/mosquitto/15_ssl_spread_100
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=200 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/mosquitto/16_ssl_spread_200
echo "mosquitto: testes ssl completos"


ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=10 --length=1000 --port=1884 > ./broker_benchmark/resultados_${prefix}/aedes/05_plain_spread_10
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=50 --length=1000 --port=1884 > ./broker_benchmark/resultados_${prefix}/aedes/06_plain_spread_50
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=100 --length=1000 --port=1884 > ./broker_benchmark/resultados_${prefix}/aedes/07_plain_spread_100
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=200 --length=1000 --port=1884 > ./broker_benchmark/resultados_${prefix}/aedes/08_plain_spread_200
echo "aedes: testes plain completos"
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=10 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/aedes/13_ssl_spread_10
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=50 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/aedes/14_ssl_spread_50
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=100 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/aedes/15_ssl_spread_100
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=200 --length=1000 --port=8884 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/aedes/16_ssl_spread_200
echo "aedes: testes ssl completos"


ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=10 --length=1000 --port=1885 > ./broker_benchmark/resultados_${prefix}/hivemq/05_plain_spread_10
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=50 --length=1000 --port=1885 > ./broker_benchmark/resultados_${prefix}/hivemq/06_plain_spread_50
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=100 --length=1000 --port=1885 > ./broker_benchmark/resultados_${prefix}/hivemq/07_plain_spread_100
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=200 --length=1000 --port=1885 > ./broker_benchmark/resultados_${prefix}/hivemq/08_plain_spread_200
echo "hivemq: testes plain completos"
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=10 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/hivemq/13_ssl_spread_10
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=50 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/hivemq/14_ssl_spread_50
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=100 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/hivemq/15_ssl_spread_100
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=200 --length=1000 --port=8885 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados_${prefix}/hivemq/16_ssl_spread_200
echo "hivemq: testes ssl completos"
cd broker_benchmark
mv resultados_${prefix} resultados_${prefix}_$2
