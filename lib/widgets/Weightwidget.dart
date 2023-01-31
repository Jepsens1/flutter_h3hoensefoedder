import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/Objects/WeightObject.dart';

class WeightWidget extends StatefulWidget {
  WeightWidget({super.key, required this.manager});
  DataManager manager;
  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
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
      color: Colors.orange,
      height: 50,
      width: 150,
      child: Center(
        child: FutureBuilder(
          future: GetData(),
          builder: ((context, snapshot) {
            List<Widget> childs;
            if (snapshot.hasData) {
              childs = <Widget>[
                Text("Food weight is ${data?.Foodweight}",
                    style: TextStyle(color: Colors.white)),
                Text("Egg weight is ${data?.Eggweight}",
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
