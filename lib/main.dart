import 'package:flutter/material.dart';
import 'custom_card.dart';
import 'elevButton.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

void main() {
  const int primaryColor = 0xFF1d2136;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Source Sans Pro",
        scaffoldBackgroundColor: const Color(primaryColor),
        appBarTheme: const AppBarTheme(backgroundColor: Color(primaryColor)),
        useMaterial3: false),
    home: const BMI(),
  ));
}

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  bool male = false;
  bool female = false;
  int notPressed = 0xFF25263b;
  int isPressed = 0xFF323244;
  int age = 10;
  int weight = 50;
  double _value = 150;

  // Gender selection function
  void getGender(int button) {
    if (!male && button == 1) {
      male = true;
      female = false;
    } else if (!female && button == 2) {
      female = true;
      male = false;
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "BMI CALCULATOR",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gender Area
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => setState(() => getGender(1)),
                    style: ElevatedButton.styleFrom(
                      overlayColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: customCard(
                      getColor: male ? notPressed : isPressed,
                      getWidgets: [
                        Icon(
                          Icons.male,
                          size: 110,
                          color: male ? Colors.blueAccent : Colors.white,
                        ),
                        const Text("MALE"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => setState(() => getGender(2)),
                    style: ElevatedButton.styleFrom(
                      overlayColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: customCard(
                      getColor: female ? notPressed : isPressed,
                      getWidgets: [
                        Icon(
                          Icons.female,
                          size: 110,
                          color: female ? Colors.pinkAccent : Colors.white,
                        ),
                        const Text("FEMALE"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Height Area
            customCard(
              getColor: isPressed,
              getWidgets: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "HEIGHT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF6f6f7f),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_value.toInt()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial",
                        fontSize: 50,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("CM"),
                    )
                  ],
                ),
                SfSlider(
                  onChanged: (dynamic value) =>
                      setState(() => _value = value + 5),
                  activeColor: Colors.pinkAccent,
                  min: 110,
                  max: 195,
                  value: _value,
                  showTicks: true,
                  interval: 5,
                ),
              ],
            ),
            // Weight & Age Area
            Row(
              children: [
                Flexible(
                  child: customCard(
                    getColor: isPressed,
                    getWidgets: [
                      const Text(
                        "WEIGHT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF6f6f7f),
                        ),
                      ),
                      Text(
                        "$weight",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Arial",
                          fontSize: 50,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Elevbutton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => getNewValue(id: "weight", type: false),
                          ),
                          const SizedBox(width: 5),
                          Elevbutton(
                            icon: const Icon(Icons.add),
                            onPressed: () => getNewValue(id: "weight", type: true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: customCard(
                    getColor: isPressed,
                    getWidgets: [
                      const Text(
                        "AGE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF6f6f7f),
                        ),
                      ),
                      Text(
                        "$age",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Arial",
                          fontSize: 50,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Elevbutton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => getNewValue(id: "age", type: false),
                          ),
                          const SizedBox(width: 5),
                          Elevbutton(
                            icon: const Icon(Icons.add),
                            onPressed: () => getNewValue(id: "age", type: true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
