import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
final String assetName = 'assets/images/logo.svg';

class HomeDesktopPage extends StatefulWidget {
  @override
  _HomeDesktopPageState createState() => _HomeDesktopPageState();
}



class _HomeDesktopPageState extends State<HomeDesktopPage> {
  IO.Socket socket;
  int _triagem;
  
  String _status = "";

  final Widget svg = SvgPicture.asset(
    assetName,
    semanticsLabel: 'Acme Logo'
  );

  @override
  void initState() {

    // Dart client
    print("[webscoket][iniciado]");
    socket = IO.io('http://192.168.20.9:3000', <String, dynamic>{
      'transports': ['websocket'],
    });
    print("[webscoket][recebendo data]");
    socket.on('greeting', (data) {
      print("[data][servidor]$data");
      setState(() {
        _triagem = data['triagem'];
        _status = data['status'];
      });
    });
    socket.on('[webscoket][disconnect]', (_) => print('disconnect'));    
    print("[webscoket][conectado]");  
    socket.connect();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromRGBO(4, 118, 73, 0.5),
        backgroundColor: Colors.white,
        leading: svg,
        elevation: 2,
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
          )
          
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
            Text('Testando evento'),
            Text(
              _triagem != null ?'TRIAGEM: $_triagem' : '',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              _status.isNotEmpty ?'STATUS: $_status':'',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pusher/pusher.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var channelController = TextEditingController(text: "my-channel");
//   var eventController = TextEditingController(text: "my-event");
//   String texto = '';
//   Pusher pusher;

//   @override
//   void initState() {
//     super.initState();
//     initPusher();
//   }

//   Future<void> initPusher() async {
//     try {
//       Pusher pusher = new Pusher(
//         '1076821', 
//         'c61586499076687b027e', 
//         '8000c65c71be3a5ca652',
//         PusherOptions(cluster: 'us2', encrypted: true)
//       );
//       Map data = {'message': 'Hello world'};
//       Response result = await pusher.trigger(['my_channel'], 'my_event', data);
//       print("Status - $result.status");
//     } on PlatformException catch (e) {
//       print(e.message);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Plugin example app'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               RaisedButton(
//                 child: Text("Connect"),
//                 onPressed: () async {
//                   Map data = {'message': 'Hello world'};
//                   Response result = await pusher.trigger(['my_channel'], 'my_event', data);
//                   print(result);
//                   setState(() {
//                     texto = result.message.toString();
//                   });
//                 },
//               ),
//               Text(texto),
//               RaisedButton(
//                 child: Text("Disconnect"),
//                 onPressed: () {
//                   //Pusher.disconnect();
//                 },
//               ),
//             ],
//           ),
//         )
//       ),
//     );
//   }
// }
















// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/app/modules/home/home_controller.dart';
// import 'package:pusher/pusher.dart';

// class HomePage extends GetView<HomeController> {

  
 
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _controller = TextEditingController();

//     Future<void> initPusher() async {
//       try {
//        Pusher pusher = new Pusher('1076821', 'c61586499076687b027e', '8000c65c71be3a5ca652');
//         Map data = {'message': 'Hello world'};
//         await pusher.trigger(['test_channel'], 'my_event', data);
//       }  catch (e) {
//         print(e.message);
//       }
//     }

//     return Scaffold(
//     appBar: AppBar(title: Text('HomePage')),

//     body: Container(
//       child: GetX<HomeController>(
//         init: HomeController(),
//         builder: (_){
//           return Container(
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: TextFormField(
//                           controller: _controller,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5)
//                             ),
//                             hintText: 'Digite texto'
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: RaisedButton(
//                         color: Colors.teal,
//                         child: Text(
//                           'Enviar',
//                           style: TextStyle(
//                             color: Colors.white
//                           ),
//                         ),
//                         onPressed: (){
//                           _.obj = _controller.text;
//                           _controller.text = '';
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: getMessageList(_.obj)
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
//   Widget getMessageList(List items){

//     return ListView.builder(
//       itemCount: items.length,      
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Container(
//             color: Colors.teal[50],
//             height: 60,
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 items[index],
//                 style: TextStyle(
//                   fontSize: 22
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//     // List<Widget> listWidget = [];
//     // for (String message in items) {
//     //   listWidget.add(
//     //     // ListTile(
//     //     //   title: Container(
//     //     //     child: Padding(
//     //     //       padding: const EdgeInsets.all(8),
//     //     //       child: Text(
//     //     //         message,
//     //     //         style: TextStyle(
//     //     //           fontSize: 22
//     //     //         ),
//     //     //       ),
//     //     //     ),
//     //     //     color: Colors.teal[50],
//     //     //     height: 60,
//     //     //   ),
//     //     ListTile(
//     //       title: Text(message),
//     //     )
//     //   );
//     // }
//     // return ListView(
//     //   children: listWidget,
//     // );
//   }
// }