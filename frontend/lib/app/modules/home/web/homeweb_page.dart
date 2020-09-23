import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
final String assetName = 'assets/images/logo.svg';

class HomeWebPage extends StatefulWidget {
  @override
  _HomeWebPageState createState() => _HomeWebPageState();
}

class _HomeWebPageState extends State<HomeWebPage> {
  IO.Socket socket;
  int dropdownValue = 1;
  int _triagens;

  final Widget svg = SvgPicture.asset(
    assetName,
    semanticsLabel: 'Acme Logo'
  );

  @override
  void initState() {
    // Dart client
    socket = IO.io('http://192.168.20.7:3000', <String, dynamic>{
      'transports': ['websocket'],
    });    
    socket.on('disconnect', (_) => print('disconnect'));
    socket.connect();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'ATENDIMENTO',
        //   style: TextStyle(
        //     color: Colors.black
        //   ),
        // ),
        // centerTitle: true,
        // backgroundColor: Colors.white,
        // elevation: 2,
        leading: SvgPicture.asset(
    assetName,
    semanticsLabel: 'Acme Logo'
  ),
        // actions: [
        //   Row(
        //     children: [
        //       Text(
        //         'TRIAGEM',
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 20
        //         ),
        //       ),
        //       Icon(
        //         Icons.computer_outlined,
        //         size: 50,
        //         color: Colors.black,                
        //       ),
        //     ],
        //   ),
        // ],
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Color.fromRGBO(4, 118, 73, 0.5)),
              underline: Container(
                height: 2,
                color: Color.fromRGBO(4, 118, 73, 0.5),
              ),
              onChanged: (int newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),            
            RaisedButton(
              child: Text('Enviar'),
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