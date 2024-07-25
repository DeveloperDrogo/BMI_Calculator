// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:bmi_flutter/api.dart';
import 'package:bmi_flutter/calculator_brain.dart';
import 'package:bmi_flutter/checkDisease.dart';

import 'package:bmi_flutter/constants.dart';
import 'package:bmi_flutter/heightAndWeightCheck.dart';
import 'package:bmi_flutter/results_page.dart';
import 'package:bmi_flutter/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DiseaseListAndCalculateBmiPage extends StatefulWidget {
  @override
  _DiseaseListAndCalculateBmiPageState createState() =>
      _DiseaseListAndCalculateBmiPageState();
}

class _DiseaseListAndCalculateBmiPageState
    extends State<DiseaseListAndCalculateBmiPage> {
  @override
  void initState() {
    Api.getFestInfo();
    super.initState();
  }

  String? selectDisease;
  int height = 180;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  DiseaseCheckPage(),
                  ));
            },
            icon: const Icon(Icons.chevron_left,size: 30,)),
        backgroundColor: const Color(0xFF090C22),
        title: const Text('HEALTH METRICS'),
        elevation: 0,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              const Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
              child: Text(
                'Select the Disease You Have',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectDisease = 'Diabetes';
                          });
                        },
                        color: selectDisease == 'Diabetes'
                            ? cActiveCardColor
                            : kInactiveCardColor,
                        cardChild: Center(
                            child: Text(
                          'Diabetes',
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ))),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectDisease = 'Hypertension';
                          });
                        },
                        color: selectDisease == 'Hypertension'
                            ? cActiveCardColor
                            : kInactiveCardColor,
                        cardChild: Center(
                            child: Text(
                          'Hypertension',
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ))),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectDisease = 'Asthma';
                          });
                        },
                        color: selectDisease == 'Asthma'
                            ? cActiveCardColor
                            : kInactiveCardColor,
                        cardChild: Center(
                            child: Text(
                          'Asthma',
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ))),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectDisease = 'Cardiovascular Disease';
                          });
                        },
                        color: selectDisease == 'Cardiovascular Disease'
                            ? cActiveCardColor
                            : kInactiveCardColor,
                        cardChild: Center(
                            child: Text(
                          'Cardiovascular Disease',
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ))),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectDisease = 'Other';
                          });
                        },
                        color: selectDisease == 'Other'
                            ? cActiveCardColor
                            : kInactiveCardColor,
                        cardChild: Center(
                            child: Text(
                          'Other',
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ))),
                  ),
                ],
              ),
            ),
            if (selectDisease != null)
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 25, top: 20),
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
                        Text('CALCULATE',
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
                      CalculatorBrain calc = CalculatorBrain(
                          disease: selectDisease!,
                          height: HeightAndWeightCheckPage.height,
                          weight: HeightAndWeightCheckPage.weight);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(
                            bmi: calc.calculateBMI(),
                            result: calc.getResult(),
                            interpretation: calc.getSuggestion(),
                            description: calc.getDescription(), disease: selectDisease!,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class IconContent extends StatelessWidget {
  final IconData icon;
  final String label;

  IconContent({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
