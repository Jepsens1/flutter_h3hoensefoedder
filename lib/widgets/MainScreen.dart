import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/widgets/HatchStatusWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/LightStatusWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/Temps.dart';
import 'package:flutter_h3hoensefoedder/widgets/WaterLevel.dart';
import 'package:flutter_h3hoensefoedder/widgets/Weightwidget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late DataManager manager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Creates DataManager object used for all widgets
    manager = DataManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arduino Project"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Parse in the manager object to widget
                TempsWidget(manager: manager),
                WaterLevel(manager: manager),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Parse in the manager object to widget
                WeightWidget(manager: manager),
                LightStatusWidget(manager: manager),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Parse in the manager object to widget
                HatchStatusWidget(manager: manager),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
