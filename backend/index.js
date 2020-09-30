var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);
var port = process.env.PORT || 3000;


io.on('connection', (socket)=>{
    socket.on('greeting', (msg) =>{
      io.emit('greeting',msg);
    });
});

io.on('connection', (socket)=>{
  socket.on('greetingTwo', (msg) =>{
    io.emit('greetingTwo',msg);
  });
});

http.listen(port, ()=>{
  console.log('listen on *: ' + port);
})