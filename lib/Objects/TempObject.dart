class TempObject {
  double? Outsidetemp;

  TempObject(this.Outsidetemp);
  TempObject.fromJson(Map<String, dynamic> json) {
    Outsidetemp = json['outsidetemp'];
  }
}
