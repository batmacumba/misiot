python3 plotutil.py ../testes/4/http/ADAPTOR ../testes/4/mqtt/ADAPTOR -c -o ADAPTOR_CPU.png
python3 plotutil.py ../testes/4/http/ADAPTOR ../testes/4/mqtt/ADAPTOR -m -o ADAPTOR_MEM.png
python3 plotutil.py ../testes/4/http/DATA ../testes/4/mqtt/DATA -c -o DATA_CPU.png
python3 plotutil.py ../testes/4/http/DATA ../testes/4/mqtt/DATA -m -o DATA_MEM.png
python3 plotutil.py ../testes/4/http/RABBITMQ ../testes/4/mqtt/RABBITMQ -c -o RABBITMQ_CPU.png
python3 plotutil.py ../testes/4/http/RABBITMQ ../testes/4/mqtt/RABBITMQ -m -o RABBITMQ_MEM.png
python3 plotutil.py ../testes/4/http/MOSQUITTO ../testes/4/mqtt/MOSQUITTO -c -o MOSQUITTO_CPU.png
python3 plotutil.py ../testes/4/http/MOSQUITTO ../testes/4/mqtt/MOSQUITTO -m -o MOSQUITTO_MEM.png