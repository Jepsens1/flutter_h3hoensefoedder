import 'dart:convert';

import 'package:flutter_h3hoensefoedder/Objects/TempObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/WaterLevelObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/WeightObject.dart';
import 'package:flutter_h3hoensefoedder/widgets/WaterLevel.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class DataHandler {
  TcpSocketConnection socketConnection =
      TcpSocketConnection("127.0.0.1", 13000);
  String message = "";
  void messageReceived(String msg) {
    message = msg;
    print(message);
  }

  void startConnection() async {
    socketConnection.enableConsolePrint(true);
    if (await socketConnection.canConnect(5000, attempts: 1000)) {
      await socketConnection.connect(5000, messageReceived, attempts: 1000);
      socketConnection.sendMessage("message");
    }
  }

  void ReceivedDataType(String type, String msg) {
    switch (type) {
      case "Temp":
        String numbers = msg.replaceAll("Temp", "").replaceAll("Water", "");
        final finalvalues = numbers.split("  ");
        TempObject tempob = TempObject(
            double.parse(finalvalues[0]), double.parse(finalvalues[1]));
        break;
      case "WaterLevel":
        String number = msg.replaceAll("WaterLevel", "");
        WaterLevelObject waterlevel = WaterLevelObject(double.parse(number));
        break;
      case "Weight":
        String weights =
            msg.replaceAll("FoodWeight", "").replaceAll("EggWeight", "");
        final finalvalues = weights.split("  ");
        WeightObject tempob = WeightObject(
            double.parse(finalvalues[0]), double.parse(finalvalues[1]));
        break;
      case "Lights":
        msg.split("Lights ");
        break;
      case "Hatch":
        msg.split("Hatch ");
        break;
    }
  }
}
