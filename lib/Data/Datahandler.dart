import 'package:flutter_h3hoensefoedder/Objects/StatusObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/TempObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/WaterLevelObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/WeightObject.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class DataHandler {
  TcpSocketConnection socketConnection = TcpSocketConnection("127.0.0.1", 9999);
  String message = "";
  void messageReceived(String msg) {
    print(msg);
    message = msg;
  }

  dynamic GetData() {
    return receivedDataType(message);
  }

  void startConnection() async {
    socketConnection.enableConsolePrint(true);
    if (await socketConnection.canConnect(5000, attempts: 1000)) {
      await socketConnection.connect(5000, messageReceived, attempts: 1);
      socketConnection.sendMessage("1");
    }
  }

  dynamic receivedDataType(String msg) {
    final type = msg.split(" ");
    switch (type[0]) {
      case "Temp":
        String numbers = msg.replaceAll("Temp", "").replaceAll("Water", "");
        final finalvalues = numbers.split("  ");
        TempObject tempob = TempObject(double.parse(finalvalues[0]), 15);
        return tempob;
      case "WaterLevel":
        String number = msg.replaceAll("WaterLevel", "");
        WaterLevelObject waterlevel = WaterLevelObject(double.parse(number));
        return waterlevel;
      case "Weight":
        String weights =
            msg.replaceAll("FoodWeight", "").replaceAll("EggWeight", "");
        final finalvalues = weights.split("  ");
        WeightObject weightObject = WeightObject(
            double.parse(finalvalues[0]), double.parse(finalvalues[1]));
        return weightObject;
      case "Lights":
        String lightstatus = msg.replaceAll("Lights", "");
        LightStatusObject light = LightStatusObject(lightstatus.toLowerCase());
        return light;
      case "Hatch":
        String hatchstatus = msg.replaceAll("Hatch", "");
        HatchStatusObject hatch = HatchStatusObject(hatchstatus.toLowerCase());
        return hatch;
    }
  }
}
