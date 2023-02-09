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

  //This method is used for our widget to get latest data
  dynamic GetData() async {
    //Checks if othe messages list is empty, if true saves the text in variable
    //Calls method and returns a object
    if (!messages.isEmpty) {
      print("in queue ${messages[0]}");
      String next = messages[0];
      messages.removeAt(0);
      return await receivedDataType(next);
    }
  }

  //This method will connect to a tcp server and handle data from server
  Future<void> startConnection() async {
    socket = await Socket.connect("192.168.1.112", 9999,
        timeout: const Duration(seconds: 6000));
    print("Connected");
    isConnected = true;
    //When connected to server, sends "1" to server
    //To let server know, its a client
    socket!.write("1");

    //Listens to when data comes from server and adds to our messages list
    socket!.listen(
        // handle data from the server
        (Uint8List data) {
      String serverResponse = String.fromCharCodes(data);
      print('Server: $serverResponse');
      //adds to our list
      messages.add(serverResponse);
    }, onDone: () {
      //onDone is when we the server is offline or we disconnect
      print("Server is offline");
      isConnected = false;
      socket!.destroy();
    }, onError: (error) {
      print(error);
      isConnected = false;
      socket!.destroy();
    });
  }

  //Sends a message to server, either open or close hatch
  //Or turn on or off lights
  void openClose(String type, bool status) {
    //Checks to see if we are still connected to server
    //if false we try to connect again
    if (isConnected) {
      socket!.add(utf8.encode("$type $status-"));
      print("Send: $type $status-");
    } else {
      startConnection();
    }
  }

  //This method returns a object depending on what the msg is
  //msg is our latest message in queue
  dynamic receivedDataType(String msg) async {
    //Splits the message, so we get the first bit of text
    //Example: Temp 20.0, msg.split will get us "Temp"
    final type = msg.split(" ");
    switch (type[0]) {
      case "Temp":
        //Replaces "Temp" with empty, so it only has the value
        String numbers = msg.replaceAll("Temp", "");
        final finalvalues = numbers.split("  ");
        TempObject tempob = TempObject(double.parse(finalvalues[0]));
        return tempob;
      case "WaterLevel":
        //Replaces "WaterLevel" with empty, so it only has the value
        String number = msg.replaceAll("WaterLevel", "");
        WaterLevelObject waterlevel = WaterLevelObject(double.parse(number));
        return waterlevel;
      case "Weight":
        //Replaces "FoodWeight" and "EggWeight" with empty, so it only has the value
        String weights =
            msg.replaceAll("FoodWeight", "").replaceAll("EggWeight", "");
        //Splits the string, so at index 0 is FoodWeight, and index 1 is EggWeight
        final finalvalues = weights.split("  ");
        WeightObject weightObject = WeightObject(
            double.parse(finalvalues[0]), double.parse(finalvalues[1]));
        return weightObject;
      case "Lights":
        //Replaces "Lights" with empty, so it only has the value
        String lightstatus = msg.replaceAll("Lights", "");
        bool lightstatusss = false;
        if (lightstatus.contains("true")) {
          lightstatusss = true;
        }
        LightStatusObject light = LightStatusObject(lightstatusss);
        return light;
      case "Hatch":
        //Replaces "Hatch" with empty, so it only has the value
        String hatchstatus = msg.replaceAll("Hatch", "");
        bool hatchstatuss = false;
        if (hatchstatus.contains("true")) {
          hatchstatuss = true;
        }
        return HatchStatusObject(hatchstatuss);
    }
  }
}
