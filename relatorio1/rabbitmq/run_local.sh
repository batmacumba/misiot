mkdir resultados
mkdir resultados/rabbitmq

ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=w --clients=1000 --length=1 --port=1883 > ./resultados/rabbitmq/01_plain_write_1
ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=w --clients=1000 --length=1000 --port=1883 > ./resultados/rabbitmq/02_plain_write_1000
ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=r --clients=1000 --length=1 --port=1883 > ./resultados/rabbitmq/03_plain_read_1
ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=r --clients=1000 --length=1000 --port=1883 > ./resultados/rabbitmq/04_plain_read_1000
ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=s --clients=10 --length=1000 --port=1883 > ./resultados/rabbitmq/05_plain_spread_10
ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=s --clients=50 --length=1000 --port=1883 > ./resultados/rabbitmq/06_plain_spread_50
ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=s --clients=100 --length=1000 --port=1883 > ./resultados/rabbitmq/07_plain_spread_100
ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=s --clients=200 --length=1000 --port=1883 > ./resultados/rabbitmq/08_plain_spread_200
echo "rabbitmq: testes plain completos"
# ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=w --clients=1000 --length=1 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/rabbitmq/09_ssl_write_1
# ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=w --clients=1000 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/rabbitmq/10_ssl_write_1000
# ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=r --clients=1000 --length=1 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/rabbitmq/11_ssl_read_1
# ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=r --clients=1000 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/rabbitmq/12_ssl_read_1000
# ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=s --clients=10 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/rabbitmq/13_ssl_spread_10
# ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=s --clients=50 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/rabbitmq/14_ssl_spread_50
# ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=s --clients=100 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/rabbitmq/15_ssl_spread_100
# ruby mqttperf/mqttperf.rb --address=127.0.0.1 --mode=s --clients=200 --length=1000 --port=8883 --key=mqttperf/key.pem --cert=mqttperf/cert.pem > ./broker_benchmark/resultados/rabbitmq/16_ssl_spread_200
# echo "rabbitmq: testes ssl completos"
