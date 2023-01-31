import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/Objects/StatusObject.dart';
import 'package:flutter_h3hoensefoedder/Objects/TempObject.dart';

class LightStatusWidget extends StatefulWidget {
  LightStatusWidget({super.key, required this.manager});
  DataManager manager;
  @override
  State<LightStatusWidget> createState() => _LightStatusWidgetState();
}

class _LightStatusWidgetState extends State<LightStatusWidget> {
  LightStatusObject? data;
  Future<LightStatusObject?> GetData() async {
    var recieveddata = await widget.manager.GetData();
    if (recieveddata.runtimeType == LightStatusObject) {
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
      color: Colors.green,
      height: 50,
      width: 150,
      child: Center(
        child: FutureBuilder(
          future: GetData(),
          builder: ((context, snapshot) {
            List<Widget> childs;
            if (snapshot.hasData) {
              childs = <Widget>[
                Text(
                  data!.status,
                  style: TextStyle(color: Colors.white),
                ),
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
