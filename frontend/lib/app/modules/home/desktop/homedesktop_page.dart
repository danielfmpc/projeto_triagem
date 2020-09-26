
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/utils/window_size.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeDesktopPage extends StatefulWidget {
  @override
  _HomeDesktopPageState createState() => _HomeDesktopPageState();
}

class _HomeDesktopPageState extends State<HomeDesktopPage> {
  IO.Socket socket;
  String _triagem = "";
  String _status = "";
  AudioCache audioCache;
  AudioPlayer audioPlayer = AudioPlayer();

  


  @override
  void initState() {
    audioCache = AudioCache();

    WindowSizeService().initialize();

    // Dart client
    print("[webscoket][iniciado]");
    socket = IO.io('http://192.168.20.237:3000', <String, dynamic>{
      'transports': ['websocket'],
    });
    print("[webscoket][recebendo data]");
    socket.on('greeting', (data) {
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

  playAudioFromLocalStorage(path) async {
    audioPlayer = await audioCache.play(path);
    // if (audioPlayer == 1) {
    //   // success

    // } else {
    //   print('Some error occured in playing from storage!');
    // }
  }
  pauseAudio() async {
    int response = await audioPlayer.pause();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in pausing');
    }
  }
  stopAudio() async {
    int response = await audioPlayer.stop();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in stopping');
    }
  }
  resumeAudio() async {
    int response = await audioPlayer.resume();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in resuming');
    }
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
                style: TextStyle(color: Colors.black, fontSize: 20),
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
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [    
            FlatButton(
              onPressed: ()async{
                var path = "assets/audios/chamada.mp3";
                playAudioFromLocalStorage(path);
                 
              },
              child: Text('Tocar'),
            ),        
            Padding(
              padding: const EdgeInsets.only(top: 29, left: 8, right: 8),
              child: Container(
                alignment: Alignment.topCenter,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    _triagem.isNotEmpty
                        ? 'TRIAGEM ${_status.toUpperCase()}'
                        : '',
                    style: TextStyle(
                      fontSize: 125,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            
            
            Padding(
              padding: const EdgeInsets.only(top: 26, left: 8, right: 8),
              child: Container(
                height: 390,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    _triagem != null ? '$_triagem' : '',
                    style:
                        TextStyle(fontSize: 300, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
