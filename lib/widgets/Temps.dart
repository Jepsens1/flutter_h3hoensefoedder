import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/Objects/TempObject.dart';

class TempsWidget extends StatefulWidget {
  const TempsWidget({super.key, required this.manager});

  final DataManager manager;
  @override
  State<TempsWidget> createState() => _TempsWidgetState();
}

class _TempsWidgetState extends State<TempsWidget> {
  late Future<TempObject> tempobj;
  Future<TempObject> getData() async {
    var recieveddata = await widget.manager.GetData();
    if (recieveddata.runtimeType == TempObject) {
      return recieveddata;
    }
    return TempObject(0, 0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempobj = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: const BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: FutureBuilder<TempObject>(
          future: tempobj,
          builder: (BuildContext context, AsyncSnapshot<TempObject> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return Text("${snapshot.data!.Outsidetemp}",
                    style: const TextStyle(color: Colors.cyan, fontSize: 36));
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
    );
  }
}
