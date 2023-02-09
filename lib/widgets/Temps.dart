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
  late Stream<TempObject> tempobj;
  Stream<TempObject> getData() async* {
    await Future.delayed(Duration(seconds: 1));
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      var recieveddata = await widget.manager.GetData();
      if (recieveddata.runtimeType == TempObject) {
        yield recieveddata as TempObject;
      }
    }
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
      child: StreamBuilder<TempObject>(
          stream: tempobj,
          builder: (BuildContext context, AsyncSnapshot<TempObject> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
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
                        'Awaiting result...',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]));
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return Center(
                    child: Text("Temp: ${snapshot.data!.Outsidetemp}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)));
              } else {
                return const Text('Empty data',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold));
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
    );
  }
}
