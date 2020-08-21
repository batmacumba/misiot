
echo "local rabbitmq 05_plain_spread_10 mean"
python3 parse_data.py local rabbitmq 05_plain_spread_10 mean | python3 process_results.py
#read varname
echo "local rabbitmq 06_plain_spread_50 mean"
python3 parse_data.py local rabbitmq 06_plain_spread_50 mean | python3 process_results.py
#read varname
echo "local rabbitmq 07_plain_spread_100 mean"
python3 parse_data.py local rabbitmq 07_plain_spread_100 mean | python3 process_results.py
#read varname
echo "local rabbitmq  08_plain_spread_200 mean"
python3 parse_data.py local rabbitmq 08_plain_spread_200 mean | python3 process_results.py
#read varname
echo "local rabbitmq 13_ssl_spread_10 mean"
python3 parse_data.py local rabbitmq 13_ssl_spread_10 mean | python3 process_results.py
#read varname
echo "local rabbitmq 14_ssl_spread_50 mean"
python3 parse_data.py local rabbitmq 14_ssl_spread_50 mean | python3 process_results.py
#read varname
echo "local rabbitmq 15_ssl_spread_100 mean"
python3 parse_data.py local rabbitmq 15_ssl_spread_100 mean | python3 process_results.py
#read varname
echo "local rabbitmq 16_ssl_spread_200 mean"
python3 parse_data.py local rabbitmq 16_ssl_spread_200 mean | python3 process_results.py
#read varname

echo "remote rabbitmq 05_plain_spread_10 mean"
python3 parse_data.py remote rabbitmq 05_plain_spread_10 mean | python3 process_results.py
#read varname
echo "remote rabbitmq 06_plain_spread_50 mean"
python3 parse_data.py remote rabbitmq 06_plain_spread_50 mean | python3 process_results.py
#read varname
echo "remote rabbitmq 07_plain_spread_100 mean"
python3 parse_data.py remote rabbitmq 07_plain_spread_100 mean | python3 process_results.py
#read varname
echo "remote rabbitmq  08_plain_spread_200 mean"
python3 parse_data.py remote rabbitmq 08_plain_spread_200 mean | python3 process_results.py
#read varname
echo "remote rabbitmq 13_ssl_spread_10 mean"
python3 parse_data.py remote rabbitmq 13_ssl_spread_10 mean | python3 process_results.py
#read varname
echo "remote rabbitmq 14_ssl_spread_50 mean"
python3 parse_data.py remote rabbitmq 14_ssl_spread_50 mean | python3 process_results.py
#read varname
echo "remote rabbitmq 15_ssl_spread_100 mean"
python3 parse_data.py remote rabbitmq 15_ssl_spread_100 mean | python3 process_results.py
#read varname
echo "remote rabbitmq 16_ssl_spread_200 mean"
python3 parse_data.py remote rabbitmq 16_ssl_spread_200 mean | python3 process_results.py
#read varname
