var express = require('express');

const User = require("../models/User");

module.exports = {
  async index(request, response) {
    var io = request.app.get('socket.io');
    io.on('connection', (socket) => {
      
      socket.on('greeting', (msg) => {
        io.emit('greeting', msg);
      });
      console.log(socket.id);
    });
    // io.on('connection', (socket)=>{
    //   socket.on('greeting', (msg) =>{
    //     io.emit('greeting', msg);
    //   });
    //   console.log(socket);
    //   console.log(socket.id);

    // });

    const user = await User.findAll();
    return response.json(user);
    
    
  },

  async store(request, response){
    const { name, cpf, birth } = request.body;
    const checkCpf = await User.findOne({where: {cpf}});
    if(checkCpf){      
      return response.status(401).send({msg: "cpf já cadastrado"});
    }
    const user = await User.create(
      {
        name,
        cpf,
        birth
      }
    );    
    return response.json(user);
  }
  
}