import 'package:flutter_h3hoensefoedder/Data/Datahandler.dart';

class DataManager {
  DataHandler handler = DataHandler();
  DataManager() {
    //Connects to our tcp server, when creating DataManager object
    handler.startConnection();
  }
  Future<dynamic> GetData() async {
    return await handler.GetData();
  }

  //Calls method from datahandler, to either open or close hatch
  //Or turn on or off lights
  void openClose(String type, bool status) async {
    handler.openClose(type, status);
  }
}
