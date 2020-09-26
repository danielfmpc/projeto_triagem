import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeWebPage extends StatefulWidget {
  @override
  _HomeWebPageState createState() => _HomeWebPageState();
}

class _HomeWebPageState extends State<HomeWebPage> {
  IO.Socket socket;
  String dropdownValue = "01";

  @override
  void initState() {
    // Dart client
    socket = IO.io('http://192.168.20.237:3000', <String, dynamic>{
      'transports': ['websocket'],
    });    
    
    socket.connect();
    super.initState();
  }

  

  @override
  void dispose() {
    socket.on('disconnect', (_) => print('disconnect'));
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 100, 1),
      appBar: AppBar(
        // backgroundColor: Color.fromRGBO(4, 118, 73, 0.5),
        backgroundColor: Colors.white,
        leading: Image.asset('assets/images/logo.png'),
        actions: [
          Row(
            children: [              
              Text(
                'TRIAGEM',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
              Icon(
                Icons.computer_outlined,
                size: 50,
                color: Colors.black,
              ),
            ],
          ),
        ],        
        leadingWidth: 180,
        title: Text(
          'ATENDIMENTO',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SELECIONE O TERMINAL',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white
              ),
            ),
            DropdownButton<String>(              
              value: dropdownValue,
              dropdownColor: Colors.black,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30
              ),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>[
                "01","02","03","04","05","06","07","08","09","10","11","12","13","14"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),            
            RaisedButton(
              child: Text('CHAMAR'),
              onPressed: (){
                socket.emit('greeting', {"triagem": dropdownValue, "status": "livre"});
              },
            ),
          ],
        ),
      ),
    );
  }
}