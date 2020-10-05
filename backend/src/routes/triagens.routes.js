var express = require('express');
var triagensRouter = express.Router();

triagensRouter.get('/', (request, response)=>{
  return response.send({msg:"ok"});
});

triagensRouter.post('/', (request, response)=>{
  return response.send({msg:"ok"});
});

module.exports = triagensRouter;
