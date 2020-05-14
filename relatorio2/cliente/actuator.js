const util = require('util');
const axios = require('axios');

var startTime, endTime;
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

startTime = new Date();
axios.post('http://18.231.34.246:8000/actuator/commands', actuator)
.then(function (response) {
  // console.log(response.data);
  endTime = new Date();
  var timeDiff = endTime - startTime; //in ms
  console.log(timeDiff);
})
.catch(function (error) {
  console.log(error);
});
