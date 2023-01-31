import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/Objects/StatusObject.dart';

class HatchStatusWidget extends StatefulWidget {
  HatchStatusWidget({super.key, required this.manager});
  DataManager manager;
  @override
  State<HatchStatusWidget> createState() => _HatchStatusWidgetState();
}

class _HatchStatusWidgetState extends State<HatchStatusWidget> {
  HatchStatusObject? data;
  Future<HatchStatusObject?> GetData() async {
    var recieveddata = await widget.manager.GetData();
    if (recieveddata.runtimeType == HatchStatusObject) {
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
