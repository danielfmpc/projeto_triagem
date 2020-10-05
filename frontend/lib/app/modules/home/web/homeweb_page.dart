import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/app/modules/home/web/cookie_manager.dart';
import 'package:get_ip/get_ip.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:universal_html/html.dart';

class HomeWebPage extends StatefulWidget {
  @override
  _HomeWebPageState createState() => _HomeWebPageState();
}

class _HomeWebPageState extends State<HomeWebPage> {
  IO.Socket socket;
  String dropdownValue = "01";
  String test = '';
  String ipAddress = '';
  _onLoginButtonPressed() async {
    
    ipAddress = await GetIp.ipAddress;
    
    print(ipAddress); //192.168.232.2
  }
  

  @override
  void initState() {
    if(CookieManager.getCookie('triagem').isEmpty){
      dropdownValue = "01";
    } else {
      dropdownValue = CookieManager.getCookie('triagem');
    }
    _onLoginButtonPressed();
    
    
    // Dart client
    socket = IO.io('http://localhost:3000/', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('greeting', (data) {
      setState(() {
        print(data);
      });
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
              test,
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
                  CookieManager.addToCookie('triagem', dropdownValue);                  
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
            Text(ipAddress, style: TextStyle(color: Colors.white),),
            RaisedButton(
              child: Text(
                'CHAMAR', 
                style: TextStyle(
                  fontSize: 19
                ),
              ),  
              color: Colors.white,               
              onPressed: (){
                _onLoginButtonPressed();
                // int dropdownValueParse = int.parse(dropdownValue);
                // if(dropdownValueParse <= 7){
                  //socket.emit('greeting', {"triagem": dropdownValue, "status": "livre"});
                // } else {
                //   socket.emit('greetingTwo', {"triagem": dropdownValue, "status": "livre"});
                // }
              },
            ),
            
          ],
        ),
      ),
    );
  }
}