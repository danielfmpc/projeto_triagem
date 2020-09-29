
import 'package:flutter/material.dart';
import 'package:flutter_audio_desktop/flutter_audio_desktop.dart';
import 'package:frontend/app/utils/window_size.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class HomeDesktopPage extends StatefulWidget {
  @override
  _HomeDesktopPageState createState() => _HomeDesktopPageState();
}

class _HomeDesktopPageState extends State<HomeDesktopPage> {
  IO.Socket socket;
  final fileName = 'chamada.mp3';
  String _triagem = "";
  String _status = "";
  AudioPlayer audioPlayer = new AudioPlayer(debug: true);
  String _textFieldValue = ''; 

  @override
  void initState() {    
    WindowSizeService().initialize();
    _textFieldValue = 'D:/triagem/data/flutter_assets/assets/audios/chamada.mp3';
    
    // Dart client
    print("[webscoket][iniciado]");
    socket = IO.io('http://192.168.50.237:3000', <String, dynamic>{
      'transports': ['websocket'],
    });
    print("[webscoket][recebendo data]");
    socket.on('greeting', (data) {
      setState(() {
        _triagem = data['triagem'];
        _status = data['status'];
        initializePlay();
      });
    });
    socket.on('[webscoket][disconnect]', (_) => print('disconnect'));
    print("[webscoket][conectado]");
    socket.connect();
    super.initState();
  }

  void initializePlay() async {
    bool result =  await audioPlayer.load(this._textFieldValue);
    if(result){
      print('loaded');
      this.setState(() {});
      if (!audioPlayer.isLoaded) {
        print('Load audio first.');
      } else {
        if (audioPlayer.isPaused) {
          /// Playing loaded audio file.
          this.audioPlayer.play();
        } else if (audioPlayer.isPlaying) {
          /// Pausing playback of loaded audio file.
          this.audioPlayer.pause();
        }
      }
    } else {
      print('not loaded');
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
                style: TextStyle(color: Colors.white, fontSize: 20),
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
