import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/widgets/StatusWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/Temps.dart';
import 'package:flutter_h3hoensefoedder/widgets/WaterLevel.dart';
import 'package:flutter_h3hoensefoedder/widgets/Weightwidget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //TcpSocketConnection socketConnection = TcpSocketConnection("10.0.2.2", 13000);

  //String message = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //startConnection();
  }

  // void messageReceived(String msg) {
  // setState(() {
  // message = msg;
  //});
  //Timer(const Duration(seconds: 5),
  // (() => socketConnection.sendMessage("message")));
  //}

  //void startConnection() async {
  //socketConnection.enableConsolePrint(true);
  //if (await socketConnection.canConnect(5000, attempts: 5)) {
  //  await socketConnection.connect(5000, messageReceived, attempts: 5);
  // }
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arduino Project"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                TempsWidget(),
                WaterLevel(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                WeightWidget(),
                StatusWidget(
                  title: "Lights status",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                StatusWidget(
                  title: "Hatch closed",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
