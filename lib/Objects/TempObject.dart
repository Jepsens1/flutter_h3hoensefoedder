class TempObject {
  double? Watertemp;
  double? Outsidetemp;

  TempObject(this.Watertemp, this.Outsidetemp);
  TempObject.fromJson(Map<String, dynamic> json) {
    Watertemp = json['watertemp'];
    Outsidetemp = json['outsidetemp'];
  }
}
