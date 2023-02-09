import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_h3hoensefoedder/Objects/StatusObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/TempObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/WaterLevelObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/WeightObject.dart';

class DataHandler {
  List<String> messages = List.empty(growable: true);
  bool isConnected = false;
  Socket? socket;

  dynamic GetData() async {
    if (!messages.isEmpty) {
      print("in queue ${messages[0]}");
      String test = messages[0];
      messages.removeAt(0);
      return await receivedDataType(test);
    }
  }

  Future<void> startConnection() async {
    socket = await Socket.connect("192.168.1.112", 9999,
        timeout: const Duration(seconds: 6000));
    print("Connected");
    isConnected = true;
    socket!.write("1");

    socket!.listen(
        // handle data from the server
        (Uint8List data) {
      String serverResponse = String.fromCharCodes(data);
      print('Server: $serverResponse');
      messages.add(serverResponse);
    }, onDone: () {
      print("Server is offline");
      isConnected = false;
      socket!.destroy();
    }, onError: (error) {
      print(error);
      isConnected = false;
      socket!.destroy();
    });
  }

  void openClose(String type, bool status) {
    if (isConnected) {
      socket!.add(utf8.encode("$type $status-"));
      print("Send: $type $status-");
    } else {
      startConnection();
    }
  }

  dynamic receivedDataType(String msg) async {
    final type = msg.split(" ");
    switch (type[0]) {
      case "Temp":
        String numbers = msg.replaceAll("Temp", "");
        final finalvalues = numbers.split("  ");
        TempObject tempob = TempObject(double.parse(finalvalues[0]));
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
        bool lightstatusss = false;
        if (lightstatus.contains("true")) {
          lightstatusss = true;
        }
        LightStatusObject light = LightStatusObject(lightstatusss);
        return light;
      case "Hatch":
        String hatchstatus = msg.replaceAll("Hatch", "");
        bool hatchstatuss = false;
        if (hatchstatus.contains("true")) {
          hatchstatuss = true;
        }
        return HatchStatusObject(hatchstatuss);
    }
  }
}
