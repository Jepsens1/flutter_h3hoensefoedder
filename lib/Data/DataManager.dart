import 'package:flutter_h3hoensefoedder/Data/Datahandler.dart';
import 'package:flutter_h3hoensefoedder/Objects/TempObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/WaterLevelObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/WeightObject.dart';

class DataManager {
  DataHandler handler = DataHandler();
  DataManager() {
    handler.startConnection();
  }
  Future<dynamic> GetData() async {
    return handler.GetData();
  }

  Future<WeightObject> GetWeight() async {
    return WeightObject(40, 10);
  }

  Future<WaterLevelObject> GetWaterLevel() async {
    return WaterLevelObject(10);
  }
}
