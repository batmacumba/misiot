const util = require('util');
const axios = require('axios');

var resource_actuator = {
  "data": {
<<<<<<< HEAD
    "description": "Um semáforo na cidade",
=======
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
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
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

<<<<<<< HEAD
var capability = {
  "name": "temperatura",
=======
var temperature = {
  "name": "temperature",
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
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
<<<<<<< HEAD
    "uuid": "c61385b3-a9d6-4fb5-83c7-7712ac7d3d88",
    "capabilities": [
      "semaphore"
    ],
    "url": "http://127.0.0.1:8877"
=======
    "uuid": "24d526b8-1e43-4b8e-8c8b-1bb79fa4d894",
    "capabilities": [
      "illuminate"
    ],
    "url": "http://127.0.0.1:5000"
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
  }
};

var actuator = {
  "data": [
    {
<<<<<<< HEAD
      "uuid": "c61385b3-a9d6-4fb5-83c7-7712ac7d3d88",
      "capabilities": {
        "semaphore": "green"
=======
      "uuid": "24d526b8-1e43-4b8e-8c8b-1bb79fa4d894",
      "capabilities": {
        "illuminate": "green"
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
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
<<<<<<< HEAD
      "temperatura": 99,
=======
      "teste": 0,
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
      "timestamp": "2020-06-14T17:52:25.428Z"
    }
]};

/* NOVA CAPABILITY */
<<<<<<< HEAD
// axios.post('http://127.0.0.1:3000/capabilities', capability)
//   .then(function (response) {
//     console.log(response.data);
//   })
//   .catch(function (error) {
//     console.log(error);
//   });
  
/* NOVO RESOURCE */
// axios.post('http://127.0.0.1:3003/resources', resource)
=======
// axios.post('http://127.0.0.1:3003/capabilities', temperature)
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
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
<<<<<<< HEAD
// axios.post('http://127.0.0.1:3002/subscriptions', subscription)
//   .then(function (response) {
//     console.log(response.data);
//   })
//   .catch(function (error) {
//     console.log(error);
//   });

/* UPDATE RESOURCE */
  // axios.put('http://127.0.0.1:3000/resources/143ef9c1-0422-4d59-b7fb-02b1b84827c6', updated_resource)
=======
  // axios.post('http://127.0.0.1:3002/subscriptions', subscription)
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });

/* UPDATE RESOURCE */
  // axios.put('http://18.231.34.246:3003/resources/c5be3854-9834-48df-b0c3-8fb6c4b6e54c', updated_resource)
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });

/* PUT DATA */

<<<<<<< HEAD
 // axios.post('http://127.0.0.1:3002/resources/30b95320-5893-411c-96a6-535ae1bfde92/data/temperature', new_data)
 //  .then(function (response) {
 //    console.log(response.data);
 //  })
 //  .catch(function (error) {
 //    console.log(error);
 //  });

/* SEND ACTUATOR COMMAND */
  axios.post('http://127.0.0.1:3000/commands', actuator)
=======
 axios.post('http://127.0.0.1:3002/resources/449b59e0-e93d-46f7-b4bd-54905c478761/data/teste', new_data)
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
  .then(function (response) {
    console.log(response.data);
  })
  .catch(function (error) {
    console.log(error);
  });
<<<<<<< HEAD
=======

/* SEND ACTUATOR COMMAND */
  // axios.post('http://127.0.0.1:3000/commands', actuator)
  // .then(function (response) {
  //   console.log(response.data);
  // })
  // .catch(function (error) {
  //   console.log(error);
  // });
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
