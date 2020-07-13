const util = require('util');
const axios = require('axios');

var resource = {
  "data": {
    "description": "Quarto",
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
      "temperature"
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

var capability = {
  "name": "temperature",
  "description": "Measure the temperature of the environment",
  "capability_type": "sensor"
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
    "uuid": "0e76dc01-5a85-4e3d-98a0-867505c10b3d",
    "capabilities": [
      "termostato"
    ],
    "url": "http://10.144.0.1"
  }
};

var actuator = {
  "data": [
    {
      "uuid": "0e76dc01-5a85-4e3d-98a0-867505c10b3d",
      "capabilities": {
        "termostato": "67"
      }
    }
  ]
};

var updated_subscription = {
  "subscription": {
    "url": "http://10.144.0.1"
  }
};

var new_data = {
  "data": [
    {
      "temperatura": 10,
      "timestamp": "2017-06-14T17:52:25.428Z"
    }
]};

/* NOVA CAPABILITY */
axios.post('http://10.144.0.6:8000/catalog/capabilities', capability)
  .then(function (response) {
    console.log(response.data);
  })
  .catch(function (error) {
    console.log(error);
  });
  
/* NOVO RESOURCE */
// axios.post('http://10.144.0.6:8000/catalog/resources', resource_adaptado)
//   .then(function (response) {
//     console.log(response.data);
//   })
//   .catch(function (error) {
//     console.log(error);
//   });



// /* NOVA SUBSCRIPTION */
// axios.post('http://18.231.34.246:8000/adaptor/subscriptions', subscription)
//   .then(function (response) {
//     console.log(response.data);
//   })
//   .catch(function (error) {
//     console.log(error);
//   });

/* UPDATE RESOURCE */
  // axios.put('http://18.231.34.246:8000/catalog/resources/c5be3854-9834-48df-b0c3-8fb6c4b6e54c', updated_resource)
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });

/* PUT DATA */
/*
 * axios.post('http://34.95.144.147:8000/adaptor/resources/652cb918-c660-48d2-8ae6-a907f3b7ffe1/data/temperatura', new_data)
  .then(function (response) {
    console.log(response.data);
  })
  .catch(function (error) {
    console.log(error);
  });*/

/* SEND ACTUATOR COMMAND */
  // axios.post('http://18.231.34.246:8000/actuator/commands', actuator)
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });
