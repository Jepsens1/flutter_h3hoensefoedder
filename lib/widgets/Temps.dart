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
  //This method is used for our StreamBuilder in our widget
  Stream<TempObject> getData() async* {
    //This delays for 2 seconds, to ensure we are connected to tcp server
    await Future.delayed(Duration(seconds: 1));
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      //Calls our Getdata() from DataManager, that recieve data from tcp via Datahandler class
      var recieveddata = await widget.manager.GetData();
      //Checks to see if the data we got from method, is TempObject
      if (recieveddata.runtimeType == TempObject) {
        //yield is used to add value, its like return except it doesn't terminate the function.
        yield recieveddata as TempObject;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Sets the tempobj to data from tcp
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
      //Uses StreamBuilder to display the latest data from tcp server
      child: StreamBuilder<TempObject>(
          stream: tempobj,
          builder: (BuildContext context, AsyncSnapshot<TempObject> snapshot) {
            //If waiting for data, will display CircularProgressIndicator
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
              //Display error message
              if (snapshot.hasError) {
                return const Text('Error');
                //Displays data from tcp
              } else if (snapshot.hasData) {
                return Center(
                    child: Text("Temp: ${snapshot.data!.Outsidetemp}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)));
                //Displays no data
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
