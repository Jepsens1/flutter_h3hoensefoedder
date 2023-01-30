import 'package:flutter/material.dart';

class ExtendedInfoWidget extends StatefulWidget {
  const ExtendedInfoWidget({super.key, required this.title});
  final String title;
  @override
  State<ExtendedInfoWidget> createState() => _ExtendedInfoWidgetState();
}

class _ExtendedInfoWidgetState extends State<ExtendedInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: const Text('Go back!'),
      ),
    );
  }
}
