var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);
var port = process.env.PORT || 3000;


io.on('connection', (socket)=>{
    socket.on('greeting', (msg) =>{
      io.emit('greeting',msg);
    });
});

// io.on('connection', (socket)=>{
//   socket.on('greeting', (msg) =>{
//     socket.broadcast.emit('greeting',{msg:'welcome: ', user: "user_" + socket.id})

//     io.emit('greeting',{msg:'welcome: ', user: "user_" + socket.id});
//   });
// });


http.listen(port, ()=>{
  console.log('listen on *: ' + port);
})