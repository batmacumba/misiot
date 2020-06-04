# "API" para integração do MQTT no INCT

#### Resource Adaptor
* /adaptor/resources: 
* /adaptor/resources/{uuid}: compatível
* /adaptor/resources/{uuid}/data: compatível
* /adaptor/resources/{uuid}/data/{capability}: compatível
* /adaptor/subscriptions (GET)
* /adaptor/subscriptions (POST)
* /adaptor/subscriptions/{id} (PUT)
* /adaptor/subscriptions/{id} (GET)
  
#### Resource Catalog
* /catalog/resources (GET)
* /catalog/resources (POST)
* /catalog/resources/sensors: compatível
* /catalog/resources/actuators: compatível
* /catalog/resources/search: possivelmente compatatível
* /catalog/resources/{uuid} (PUT)
* /catalog/resources/{uuid} (GET)
* /catalog/capabilities (GET)
* /catalog/capabilities (POST)
* /catalog/capabilities/{name} (GET)
* /catalog/capabilities/{name} (PUT)
* /catalog/capabilities/{name} (DELETE)

#### Actuator Controller
* /actuator/commands (GET)
* /actuator/commands (POST)

#### Data Collector
* /collector/resources/data:
* /collector/resources/{uuid}/data
* /collector/resources/data/last
* /collector/resources/{uuid}/data/last

#### Resource Discovery
* /discovery/resources:

# Condições de corrida na escrita dos dados
