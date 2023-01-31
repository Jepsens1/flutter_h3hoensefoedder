class LightStatusObject {
  late String status;
  LightStatusObject(this.status);

  LightStatusObject.fromJson(Map<String, dynamic> json) {
    status = json['watertemp'];
  }
}

class HatchStatusObject {
  late String status;
  HatchStatusObject(this.status);

  HatchStatusObject.fromJson(Map<String, dynamic> json) {
    status = json['watertemp'];
  }
}
