var express = require('express');
const app = express();
var http = require('http').createServer(app);
var io = require('socket.io')(http);
var port = process.env.PORT || 3000;
const cors = require('cors');
var routes = require('./routes');

require('./database');

app.use(cors());
app.use(express.json());
app.use(routes);
app.set('socket.io', io);
// app.io = io;

// io.on('connection', (socket)=>{
//   socket.on('greeting', (msg) =>{
//     io.emit('greeting', msg);
//     console.log(msg);
//   });
//   console.log(socket.id);

// });

// io.on('connection', (socket)=>{
//   //var addressRemote = socket.conn.remoteAddress;
//   //var address = splitStr(addressRemote);
//   socket.on('greetingTwo', (msg) =>{
//     io.emit('greetingTwo',msg);
//    // if((address == ipTriagem) && (msg['triagem'] == triagem)){
//    //   console.log(`IP: ${ipTriagem} - Triagem: ${triagem}`);
//    // } else {
//    //   console.log("Não permitido");
//    // }      
//   });
// });

http.listen(port, ()=>{
  console.log('listen on *: ' + port);
});