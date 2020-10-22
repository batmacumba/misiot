const util = require('util');
const axios = require('axios');

var resource = {
  "data": {
    "description": "Um semáforo na cidade",
    "capabilities": [
      "semaphore"
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
  "name": "temperatura",
  "description": "Measure the temperature of the environment",
  "capability_type": "sensor"
};

var updated_resource = {
  "data": {
    "description": "Um ônibus em SP",
    "capabilities": [
      "temperatura"
    ],
    "status": "active",
    "lat": -23.559616,
    "lon": -46.731386
  }
};

var subscription = {
  "subscription": {
    "uuid": "c61385b3-a9d6-4fb5-83c7-7712ac7d3d88",
    "capabilities": [
      "semaphore"
    ],
    "url": "http://127.0.0.1:8877"
  }
};

var actuator = {
  "data": [
    {
      "uuid": "c61385b3-a9d6-4fb5-83c7-7712ac7d3d88",
      "capabilities": {
        "semaphore": "green"
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
      "temperatura": 99,
      "timestamp": "2020-06-14T17:52:25.428Z"
    }
]};

/* NOVA CAPABILITY */
// axios.post('http://127.0.0.1:3000/capabilities', capability)
//   .then(function (response) {
//     console.log(response.data);
//   })
//   .catch(function (error) {
//     console.log(error);
//   });
  
/* NOVO RESOURCE */
// axios.post('http://127.0.0.1:3003/resources', resource)
//   .then(function (response) {
//     console.log(response.data);
//   })
//   .catch(function (error) {
//     console.log(error);
//   });



/* NOVA SUBSCRIPTION */
// axios.post('http://127.0.0.1:3002/subscriptions', subscription)
//   .then(function (response) {
//     console.log(response.data);
//   })
//   .catch(function (error) {
//     console.log(error);
//   });

/* UPDATE RESOURCE */
  // axios.put('http://127.0.0.1:3000/resources/143ef9c1-0422-4d59-b7fb-02b1b84827c6', updated_resource)
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });

/* PUT DATA */

 // axios.post('http://127.0.0.1:3002/resources/30b95320-5893-411c-96a6-535ae1bfde92/data/temperature', new_data)
 //  .then(function (response) {
 //    console.log(response.data);
 //  })
 //  .catch(function (error) {
 //    console.log(error);
 //  });

/* SEND ACTUATOR COMMAND */
  axios.post('http://127.0.0.1:3000/commands', actuator)
  .then(function (response) {
    console.log(response.data);
  })
  .catch(function (error) {
    console.log(error);
  });
