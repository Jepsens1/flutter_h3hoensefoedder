import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/Objects/StatusObject.dart';

class HatchStatusWidget extends StatefulWidget {
  const HatchStatusWidget({super.key, required this.manager});
  final DataManager manager;
  @override
  State<HatchStatusWidget> createState() => _HatchStatusWidgetState();
}

class _HatchStatusWidgetState extends State<HatchStatusWidget> {
  HatchStatusObject? data;
  late String status;
  Color? buttoncolor = Colors.red;
  //This method is used for our StreamBuilder in our widget
  Stream<HatchStatusObject?> GetData() async* {
    //This delays for 2 seconds, to ensure we are connected to tcp server
    await Future.delayed(Duration(seconds: 2));
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      //Calls our Getdata() from DataManager, that recieve data from tcp via Datahandler class
      var recieveddata = await widget.manager.GetData();
      //Checks to see if the data we got from method, is HatchStatusObject
      if (recieveddata.runtimeType == HatchStatusObject) {
        //If true we use setState to update UI with latest data
        setState(() {
          data = recieveddata;
          //if status is true (Hatch is open), button will turn green and display open
          if (data!.status) {
            buttoncolor = Colors.green;
            status = "Open";
            //Else button will be red and display closed
          } else if (!data!.status) {
            buttoncolor = Colors.red;
            status = "Closed";
          }
        });
        //yield is used to add value, its like return except it doesn't terminate the function.
        yield data;
      }
      yield data;
    }
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
      child: ElevatedButton(
        onPressed: () {
          //Checks to see if our data (HatchStatusObject) is not null
          //If true we can display our dialog box
          if (data != null) {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        //Depending on status is true or false, will display one of these text
                        data!.status
                            ? Text('Would you like to close the hatch?')
                            : Text('Would you like to open the hatch?'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        //Updates the UI
                        setState(() {
                          data!.status = !data!.status;
                        });
                        //Calls openClose method to either open or close the hatch
                        widget.manager.openClose("Hatch", data!.status);
                        widget.manager.openClose("Hatch", data!.status);
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: buttoncolor,
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        //Uses StreamBuilder to display the latest data from tcp server
        child: StreamBuilder(
          stream: GetData(),
          builder: ((context, snapshot) {
            //childs variable is used to display data
            List<Widget> childs;
            //Display latest data from tcp if the stream has data from Getdata method
            if (snapshot.hasData) {
              childs = <Widget>[
                Text(
                  status,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ];
              //Display error message
            } else if (snapshot.hasError) {
              childs = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ];
            } else {
              //If no data, will display CircularProgressIndicator
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
                  child: Text('Awaiting Hatch...',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ];
            }
            //Displays data
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
