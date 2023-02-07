import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/widgets/HatchStatusWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/LightStatusWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/LiveVideoWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/Temps.dart';
import 'package:flutter_h3hoensefoedder/widgets/WaterLevel.dart';
import 'package:flutter_h3hoensefoedder/widgets/Weightwidget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DataManager manager = DataManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                TempsWidget(manager: manager),
                WaterLevel(manager: manager),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeightWidget(manager: manager),
                LightStatusWidget(manager: manager),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HatchStatusWidget(manager: manager),
                ElevatedButton(
                  child: Text("TEST"),
                  onPressed: () {
                    manager.openClose("Lights", false);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
