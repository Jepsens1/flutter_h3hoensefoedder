import 'package:flutter/material.dart';
import 'package:flutter_h3hoensefoedder/Data/DataManager.dart';
import 'package:flutter_h3hoensefoedder/widgets/HatchStatusWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/LightStatusWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/LiveVideoWidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/Temps.dart';
import 'package:flutter_h3hoensefoedder/widgets/WaterLevel.dart';
import 'package:flutter_h3hoensefoedder/widgets/Weightwidget.dart';
import 'package:flutter_h3hoensefoedder/widgets/testwidget.dart';

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
                TempsWidget(manager: manager),
                //testwdiget(),
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
                //ElevatedButton(
                // child: Text("TEST"),
                // onPressed: () {
                //   manager.openClose("Lights", false);
                //   manager.openClose("Lights", false);
                // },
                //
              ],
            ),
          ],
        ),
      ),
    );
  }
}
