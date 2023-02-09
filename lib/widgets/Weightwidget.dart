import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/Objects/WeightObject.dart';

class WeightWidget extends StatefulWidget {
  const WeightWidget({super.key, required this.manager});
  final DataManager manager;
  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
  //THIS WIDGET NEEDS TO BE UPDATED ONCE ARDUINO FOR WATER LEVEL IS SET UP
  WeightObject? data;
  Future<WeightObject?> GetData() async {
    var recieveddata = await widget.manager.GetData();
    if (recieveddata.runtimeType == WeightObject) {
      setState(() {
        data = recieveddata;
      });
      return data;
    }
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: FutureBuilder(
          future: GetData(),
          builder: ((context, snapshot) {
            List<Widget> childs;
            if (snapshot.hasData) {
              childs = <Widget>[
                Text("Food weight is ${data?.Foodweight}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Egg weight is ${data?.Eggweight}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ];
            } else if (snapshot.hasError) {
              childs = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ];
            } else {
              childs = const <Widget>[
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Awaiting Weight...',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: childs,
              ),
            );
          }),
        ),
      ),
    );
  }
}
