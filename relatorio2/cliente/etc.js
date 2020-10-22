const util = require('util');
const axios = require('axios');

var resource_actuator = {
  "data": {
    "description": "Resource de teste - atuador",
    "capabilities": [
      "illuminate"
    ],
    "status": "active",
    "lat": -23.559616,
    "lon": -46.731386
  }
};

var resource_sensor = {
  "data": {
    "description": "Resource de teste - sensor",
    "capabilities": [
      "temperature"
    ],
    "status": "active",
    "lat": -23.559616,
    "lon": -46.731386
  }
};

var resource_adaptado = {
  "data": {
    "description": "A public bus",
    "capabilities": [
      "temperature",
      "illuminate"
    ],
    "status": "active",
    "lat": -23.559616,
    "lon": -46.731386
  },
  "adapter": {
    "protocol": "TTN",
    "address": "brazil.thethings.network",
    "port" : "8883",
    "appid": "misiot",
    "appkey": "ttn-key-********"
  }
};

var temperature = {
  "name": "temperature",
  "description": "Measure the temperature of the environment",
  "capability_type": "sensor"
};

var teste = {
  "name": "teste",
  "description": "Capability de teste",
  "capability_type": "actuator"
};

var updated_resource = {
  "data": {
    "description": "Teste de capabilities updated",
    "capabilities": [
      "illuminate"
    ],
    "status": "inactive",
    "lat": -23.559616,
    "lon": -46.731386
  }
};

var subscription = {
  "subscription": {
    "uuid": "24d526b8-1e43-4b8e-8c8b-1bb79fa4d894",
    "capabilities": [
      "illuminate"
    ],
    "url": "http://127.0.0.1:5000"
  }
};

var actuator = {
  "data": [
    {
      "uuid": "24d526b8-1e43-4b8e-8c8b-1bb79fa4d894",
      "capabilities": {
        "illuminate": "green"
      }
    }
  ]
}

var updated_subscription = {
  "subscription": {
    "url": "http://10.144.0.1"
  }
};

var new_data = {
  "data": [
    {
      "teste": 0,
      "timestamp": "2020-06-14T17:52:25.428Z"
    }
]};

/* NOVA CAPABILITY */
// axios.post('http://127.0.0.1:3003/capabilities', temperature)
//   .then(function (response) {
//     console.log(response.data);
//   })
//   .catch(function (error) {
//     console.log(error);
//   });
  
/* NOVO RESOURCE */
axios.post('http://127.0.0.1:3003/resources', resource_sensor)
  .then(function (response) {
    console.log(response.data);
  })
  .catch(function (error) {
    console.log(error);
  });



/* NOVA SUBSCRIPTION */
  // axios.post('http://127.0.0.1:3002/subscriptions', subscription)
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });

/* UPDATE RESOURCE */
  // axios.put('http://18.231.34.246:3003/resources/c5be3854-9834-48df-b0c3-8fb6c4b6e54c', updated_resource)
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });

/* PUT DATA */

 axios.post('http://127.0.0.1:3002/resources/449b59e0-e93d-46f7-b4bd-54905c478761/data/teste', new_data)
  .then(function (response) {
    console.log(response.data);
  })
  .catch(function (error) {
    console.log(error);
  });

/* SEND ACTUATOR COMMAND */
  // axios.post('http://127.0.0.1:3000/commands', actuator)
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });
