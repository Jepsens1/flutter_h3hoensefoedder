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
  Stream<HatchStatusObject?> GetData() async* {
    await Future.delayed(Duration(seconds: 2));
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      var recieveddata = await widget.manager.GetData();
      if (recieveddata.runtimeType == HatchStatusObject) {
        setState(() {
          data = recieveddata;
          if (data!.status) {
            buttoncolor = Colors.green;
            status = "On";
          } else if (!data!.status) {
            buttoncolor = Colors.red;
            status = "Off";
          }
        });
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
          if (data != null) {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
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
                        setState(() {
                          data!.status = !data!.status;
                        });
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
        child: StreamBuilder(
          stream: GetData(),
          builder: ((context, snapshot) {
            List<Widget> childs;
            if (snapshot.hasData) {
              childs = <Widget>[
                Text(
                  status,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                  child: Text('Error: ${snapshot.error}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
                  child: Text('Awaiting Hatch...',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
