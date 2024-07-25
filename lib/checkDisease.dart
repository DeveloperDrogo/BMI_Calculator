// ignore_for_file: use_build_context_synchronously

import 'package:bmi_flutter/DiseaseListAndCalculate.dart';
import 'package:bmi_flutter/api.dart';
import 'package:bmi_flutter/calculator_brain.dart';

import 'package:bmi_flutter/constants.dart';
import 'package:bmi_flutter/heightAndWeightCheck.dart';
import 'package:bmi_flutter/input_page.dart';
import 'package:bmi_flutter/results_page.dart';
import 'package:bmi_flutter/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DiseaseCheckPage extends StatefulWidget {
  @override
  _DiseaseCheckPageState createState() => _DiseaseCheckPageState();
}

class _DiseaseCheckPageState extends State<DiseaseCheckPage> {
  @override
  void initState() {
    Api.getFestInfo();
    super.initState();
  }

  String? selectOption;
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
                    builder: (context) => const HeightAndWeightCheckPage(),
                  ));
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
            )),
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
                'Select Your Health Status',
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
                          selectOption = 'Healthy';
                        });
                      },
                      color: selectOption == 'Healthy'
                          ? cActiveCardColor
                          : kInactiveCardColor,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.heart,
                        label: 'Healthy',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectOption = 'Disease';
                    Future.delayed(const Duration(milliseconds: 500))
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DiseaseListAndCalculateBmiPage(),
                            )));
                  });
                },
                color: selectOption == 'Disease'
                    ? cActiveCardColor
                    : kInactiveCardColor,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.disease,
                  label: 'Disease',
                ),
              ),
            ),
            if (selectOption == 'Healthy')
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
                          height: HeightAndWeightCheckPage.height,
                          weight: HeightAndWeightCheckPage.weight,
                          disease: '');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(
                            bmi: calc.calculateBMI(),
                            result: calc.getResult(),
                            interpretation: calc.getSuggestion(),
                            description: calc.getDescription(),
                            disease: '',
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
