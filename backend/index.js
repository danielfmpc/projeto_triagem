var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);
var port = process.env.PORT || 3000;
const mysql = require('mysql');

var ipTriagem;
var triagem;


const connection = mysql.createConnection(
  {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'dbtriagens',
    port: '3306'
  }
);



connection.connect(function (err) {
  if(err){
    console.log('error connecting' + err.stack);
    return;
  }
});

connection.query('SELECT * FROM TRIAGENS', function(err, rows, fields) {
  if(err != true){
    for (const item in rows) {
      if (rows.hasOwnProperty(item)) {
        const element = rows[item];
        ipTriagem = element['ip'];
        triagem = element['triagem'];

        //console.log(ipTriagem);
        
      }
    }
    //console.log(rows);
  } else {
    console.log('erro');
  }
});

function splitStr(str) {       
  // Function to split string 
  var string = str.split(":"); 
  console.log(string); 
  return string[3];
} 


io.on('connection', (socket)=>{
  socket.on('greeting', (msg) =>{
    io.emit('greeting',msg);
    console.log(msg);
  });

});

io.on('connection', (socket)=>{
  var addressRemote = socket.conn.remoteAddress;
  var address = splitStr(addressRemote);
  socket.on('greetingTwo', (msg) =>{
    io.emit('greetingTwo',msg);
    if((address == ipTriagem) && (msg['triagem'] == triagem)){
      console.log(`IP: ${ipTriagem} - Triagem: ${triagem}`);
    } else {
      console.log("Não permitido");
    }
    // connection.query(`INSERT INTO triagens(triagem, ocupado, ip) VALUES (${msg['triagem']}, 1, "${address}")`, function(err, result) {
    //   if(!err){
    //     console.log('Usuário cadastrado');
    //     //console.log(result);
    //   } else {
    //     console.log(err);
    //   }
    // });
      
  });
});

http.listen(port, ()=>{
  console.log('listen on *: ' + port);
})