import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/Objects/TempObject.dart';

class TempsWidget extends StatefulWidget {
  const TempsWidget({super.key});

  @override
  State<TempsWidget> createState() => _TempsWidgetState();
}

class _TempsWidgetState extends State<TempsWidget> {
  TempObject? data;
  late DataManager manager;
  Future<TempObject?> GetData() async {
    if (data == null) {
      data = await manager.GetTemps();
    }
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    manager = DataManager();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      color: Colors.red,
      child: Center(
        child: FutureBuilder(
          future: GetData(),
          builder: ((context, snapshot) {
            List<Widget> childs;
            if (snapshot.hasData) {
              childs = <Widget>[
                Text(
                  "Water temp is ${data?.Watertemp}",
                  style: TextStyle(color: Colors.white),
                ),
                Text("Outside temp is ${data?.Outsidetemp}",
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
