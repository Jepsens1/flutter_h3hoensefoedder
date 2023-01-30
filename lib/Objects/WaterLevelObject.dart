class WaterLevelObject {
  double? Waterlevel;
  WaterLevelObject(this.Waterlevel);

  WaterLevelObject.fromJson(Map<String, dynamic> json) {
    Waterlevel = json['watertemp'];
  }
}
