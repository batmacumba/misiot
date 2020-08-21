IP_Address=$1
prefix="local"

mkdir resultados_${prefix}
mkdir resultados_${prefix}/rabbitmq

ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=10 --length=1000 --port=1883 > ./resultados_${prefix}/rabbitmq/05_plain_spread_10
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=50 --length=1000 --port=1883 > ./resultados_${prefix}/rabbitmq/06_plain_spread_50
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=100 --length=1000 --port=1883 > ./resultados_${prefix}/rabbitmq/07_plain_spread_100
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=200 --length=1000 --port=1883 > ./resultados_${prefix}/rabbitmq/08_plain_spread_200
echo "rabbitmq: testes plain completos"
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=10 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./resultados_${prefix}/rabbitmq/13_ssl_spread_10
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=50 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./resultados_${prefix}/rabbitmq/14_ssl_spread_50
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=100 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./resultados_${prefix}/rabbitmq/15_ssl_spread_100
ruby mqttperf/mqttperf.rb --address=$1 --mode=s --clients=200 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./resultados_${prefix}/rabbitmq/16_ssl_spread_200
echo "rabbitmq: testes ssl completos"

mv resultados_${prefix} resultados_${prefix}_$2
