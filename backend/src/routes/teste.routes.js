var express = require('express');
var testeRouter = express.Router();

testeRouter.get('/', (request, response)=>{
  const io = request.app.get('socket.io');
  console.log(io);
  const socket_id = [];
    // socket_id.push(socket.id);
    //     // if (socket_id[0] === socket.id) {
    //     //   // remove the connection listener for any subsequent 
    //     //   // connections with the same ID
    //     //   io.removeAllListeners('connection'); 
    //     // } 
 
  io.on('connection', (socket)=>{
    socket.on('greeting', (msg) =>{
      io.emit('greeting',msg);
      console.log("teste"+msg);
    });  
  });

  return response.json({mg: "ok"});
});

testeRouter.post('/', (request, response)=>{
  return response.send({msg:"ok"});
});

module.exports = testeRouter;
