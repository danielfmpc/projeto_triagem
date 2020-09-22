var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);
var port = process.env.PORT || 3000;


// app.get('/', (request, response) =>{
//   response.sendFile(__dirname + '/index.html');
// });

io.on('connection', (socket)=>{
  console.log('Client connect: ' + socket.id);
    socket.broadcast.emit('greeting',{msg:'welcome', user: "user_" + socket.id})
    socket.emit('greeting',{msg:'welcome', user: "user_" + socket.id})
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