import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeWebPage extends StatefulWidget {
  @override
  _HomeWebPageState createState() => _HomeWebPageState();
}



class _HomeWebPageState extends State<HomeWebPage> {
  String _users = "";
  @override
  void initState() {

    // Dart client
    IO.Socket socket = IO.io('http://192.168.20.7:3000', <String, dynamic>{
      'transports': ['websocket'],
    });
    // socket.on('connection', (_) {
    //  print('connect');
    //  socket.emit('msg', 'test');
    // });
    socket.on('greeting', (data) {
      print(data);
      setState(() {
        _users += " "+data['user'];
      });
    });
    socket.on('disconnect', (_) => print('disconnect'));
    socket.connect();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeWeb socket.io'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('List Users'),
            Text(
              '$_users',
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
    );
  }
}