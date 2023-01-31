import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/Objects/WaterLevelObject.dart';

class WaterLevel extends StatefulWidget {
  WaterLevel({super.key, required this.manager});
  DataManager manager;
  @override
  State<WaterLevel> createState() => _WaterLevelState();
}

class _WaterLevelState extends State<WaterLevel> {
  WaterLevelObject? data;
  Future<WaterLevelObject?> GetData() async {
    var recieveddata = await widget.manager.GetData();
    if (recieveddata.runtimeType == WaterLevelObject) {
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
      color: Colors.blue,
      height: 50,
      width: 150,
      child: Center(
        child: FutureBuilder(
          future: GetData(),
          builder: ((context, snapshot) {
            List<Widget> childs;
            if (snapshot.hasData) {
              childs = <Widget>[
                Text("Water Level is ${data?.Waterlevel}%",
                    style: TextStyle(color: Colors.white)),
              ];
            } else if (snapshot.hasError) {
              childs = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
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
                  child: Text('Awaiting result...'),
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
