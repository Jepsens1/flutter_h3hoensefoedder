import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class LiveVideoWidget extends StatefulWidget {
  const LiveVideoWidget({super.key});

  @override
  State<LiveVideoWidget> createState() => _LiveVideoWidgetState();
}

class _LiveVideoWidgetState extends State<LiveVideoWidget> {
  Socket? _socket;
  late Stream broadcast;
  bool _isConnected = false;

  Future<Stream> connect() async {
    _socket = await Socket.connect("127.0.0.1", 13000,
        timeout: const Duration(seconds: 60));
    setState(() {
      _isConnected = true;
    });
    broadcast = _socket!.asBroadcastStream();
    return broadcast;
  }

  void disconnect() async {
    _socket!.close();
    setState(() {
      _isConnected = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _socket!.destroy();
    _socket!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            _isConnected
                ? StreamBuilder(
                    stream: broadcast,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Center(
                          child: Text("Connection Closed !"),
                        );
                      }
                      return Image.memory(
                        Uint8List.fromList(
                          base64Decode(
                            snapshot.data.toString(),
                          ),
                        ),
                        gaplessPlayback: true,
                      );
                    },
                  )
                : const Text("Trying to connect")
          ],
        ),
      ),
    );
  }
}
