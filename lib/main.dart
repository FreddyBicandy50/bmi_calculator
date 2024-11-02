/*
    ----------------------------------
    |             IMPORT               |
    ----------------------------------
*/
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter/material.dart';
import 'reusable.dart';
import 'result.dart';

/*
    ----------------------------------
    |             INIT               |
    ----------------------------------
*/
const int calculateButtonHeight = 80;
const int primaryColor = 0xFF0A0E21;
const int textPrimaryColor = 0xFF8D8E98;
const int accentColor = 0xFFEB1555;
bool male = false;
bool female = false;
int notPressed = 0xFF323244;
int isPressed = 0xFF1D1E33;
int age = 10;
int weight = 50;
int _value = 145;

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class GenderArea extends StatefulWidget {
  const GenderArea({super.key});
  @override
  State<GenderArea> createState() => _GenderAreaState();
}

class HeightArea extends StatefulWidget {
  const HeightArea({super.key});

  @override
  State<HeightArea> createState() => _HeightAreaState();
}

class WeightArea extends StatefulWidget {
  const WeightArea({super.key});

  @override
  State<WeightArea> createState() => _WeightAreaState();
}

/*
    ----------------------------------
    |             Flutter            |
    ----------------------------------
*/
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // Application Theme
    theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Source Sans Pro",
        scaffoldBackgroundColor: const Color(primaryColor),
        appBarTheme: const AppBarTheme(backgroundColor: Color(primaryColor)),
        useMaterial3: false),
    home: const BMI(),
  ));
}

class _BMIState extends State<BMI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
                child: Text("BMI CALCULATOR",
                    style: TextStyle(color: Colors.white)))),
        body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const GenderArea(),
              const HeightArea(),
              const WeightArea(),
              // CALCULATE BUTTON
              ElevatedButton(
                  onPressed: () => const ResultPage(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(accentColor)),
                  child: const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                        child: Text("CALCULATE",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ))
            ]));
  }
}

class _GenderAreaState extends State<GenderArea> {
  /*
    ----------------------------------
    |         function               |
    ----------------------------------
    update the selected gender button on user click
  */
  void getGender(int button) {
    if (!male && button == 1) {
      male = true;
      female = false;
    } else if (!female && button == 2) {
      female = true;
      male = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        // MALE BUTTON
        Expanded(
            child: ElevatedButton(
                onPressed: () => setState(() => getGender(1)),
                // BUTTON STYLE
                style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero),
                child: GenderCard(
                    gender: male, genderName: "MALE", genderIcon: Icons.male))),
        // FEMALE BUTTON
        Expanded(
            child: ElevatedButton(
                onPressed: () => setState(() => getGender(2)),
                // BUTTON STYLE
                style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero),
                child: GenderCard(
                    gender: female,
                    genderName: "FEMALE",
                    genderIcon: Icons.female))),
      ]),
    );
  }
}

class _HeightAreaState extends State<HeightArea> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(getColor: isPressed, getWidgets: [
        // HEIGHT TEXT
        const Expanded(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("HEIGHT",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(textPrimaryColor))))),
        // HEIGHT NUMBER
        Expanded(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("${_value.toInt()}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial",
                    fontSize: 50)),
            const Padding(
                padding: EdgeInsets.only(top: 20.0), child: Text("CM"))
          ]),
        ),
        // HEIGHT SLIDER
        Expanded(
            child: SfSlider(
                onChanged: (dynamic value) =>
                    setState(() => _value = value + 5),
                activeColor: const Color(accentColor),
                min: 105,
                max: 190,
                value: _value,
                showTicks: true,
                interval: 5))
      ]),
    );
  }
}

class _WeightAreaState extends State<WeightArea> {
  /*
    ----------------------------------
    |         function               |
    ----------------------------------
    update the value of age and weight when the user press
  */
  void getNewValue({required String id, required bool type}) {
    setState(() {
      if (id == "age") {
        if (type && age < 99) {
          age++;
        } else if (!type && age > 1) {
          age--;
        }
      }
      if (id == "weight") {
        if (type && weight < 250) {
          weight++;
        } else if (!type && weight > 1) {
          weight--;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: [
        // WEIGHT
        Expanded(
          child: CustomCard(getColor: isPressed, getWidgets: [
            const Text("WEIGHT",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(textPrimaryColor))),
            Text("$weight",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial",
                    fontSize: 50)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: RoundedButton(
                      onPressed: () => getNewValue(id: "weight", type: false),
                      icon: const Icon(Icons.remove))),
              const SizedBox(width: 5),
              Expanded(
                  child: RoundedButton(
                      onPressed: () => getNewValue(id: "weight", type: true),
                      icon: const Icon(Icons.add)))
            ])
          ]),
        ),
        // AGE
        Expanded(
          child: CustomCard(getColor: isPressed, getWidgets: [
            const Text("AGE",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(textPrimaryColor))),
            Text("$age",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial",
                    fontSize: 50)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: RoundedButton(
                      onPressed: () => getNewValue(id: "age", type: false),
                      icon: const Icon(Icons.remove))),
              const SizedBox(width: 5),
              Expanded(
                  child: RoundedButton(
                      onPressed: () => getNewValue(id: "age", type: true),
                      icon: const Icon(Icons.add)))
            ])
          ]),
        ),
      ]),
    );
  }
}
