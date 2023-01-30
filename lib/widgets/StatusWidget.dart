import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Objects/TempObject.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key, required this.title});

  final String title;
  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  TempObject? data;
  Future<TempObject?> GetData() async {
    if (data == null) {
      data = TempObject(20, 10);
    }
    return data;
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
                  widget.title,
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
