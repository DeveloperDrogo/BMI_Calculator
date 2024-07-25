import 'package:bmi_flutter/checkDisease.dart';
import 'package:bmi_flutter/constants.dart';
import 'package:bmi_flutter/input_page.dart';
import 'package:bmi_flutter/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HeightAndWeightCheckPage extends StatefulWidget {
  static int height = 180;
  static int weight = 60;
  static int age = 20;
  const HeightAndWeightCheckPage({super.key});

  @override
  State<HeightAndWeightCheckPage> createState() =>
      _HeightAndWeightCheckPageState();
}

class _HeightAndWeightCheckPageState extends State<HeightAndWeightCheckPage> {
  Gender? selectedGender;
  int height = 180;
  int weight = 60;
  int age = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => InputPage(),));
        }, icon:const Icon(Icons.chevron_left,size: 30,)),
        backgroundColor: const Color(0xFF090C22),
        title: const Text('HEALTH METRICS'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ReusableCard(
              color: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    activeColor: const Color.fromARGB(255, 143, 167, 255),
                    inactiveColor: Colors.grey,
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                        HeightAndWeightCheckPage.height = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {
                                setState(() {
                                  weight--;
                                  HeightAndWeightCheckPage.weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: () {
                                setState(() {
                                  weight++;
                                  HeightAndWeightCheckPage.weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                setState(() {
                                  age--;
                                  HeightAndWeightCheckPage.age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: () {
                                setState(() {
                                  age++;
                                  HeightAndWeightCheckPage.age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 20),
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 104, 113, 209),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Text('CONTINUE',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    const Spacer(),
                    SizedBox(
                      height: 20,
                      child: Lottie.asset(
                        'assets/lottie/right.json',
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  // CalculatorBrain calc =
                  //     CalculatorBrain(height: height, weight: weight);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ResultsPage(
                  //       bmi: calc.calculateBMI(),
                  //       result: calc.getResult(),
                  //       interpretation: calc.getSuggestion(),
                  //       description: calc.getDescription(),
                  //     ),
                  //   ),
                  // );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiseaseCheckPage(),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
