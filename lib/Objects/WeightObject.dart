class WeightObject {
  double? Foodweight;
  double? Eggweight;

  WeightObject(this.Foodweight, this.Eggweight);
  WeightObject.fromJson(Map<String, dynamic> json) {
    Foodweight = json['watertemp'];
    Eggweight = json['outsidetemp'];
  }
}
