import 'package:flutter_h3hoensefoedder/Data/Datahandler.dart';

class DataManager {
  DataHandler handler = DataHandler();
  DataManager() {
    handler.startConnection();
  }
  Future<dynamic> GetData() async {
    return handler.GetData();
  }

  void openClose(String type, bool status) async {
    handler.openClose(type, status);
  }
}
