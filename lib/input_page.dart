// ignore_for_file: use_build_context_synchronously

import 'package:bmi_flutter/api.dart';
import 'package:bmi_flutter/constants.dart';
import 'package:bmi_flutter/heightAndWeightCheck.dart';
import 'package:bmi_flutter/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  static Gender? gender;
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  void initState() {
    Api.getFestInfo();
    super.initState();
  }

  Gender? selectedGender;
  int height = 180;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: const Offset(-20, 0),
          child: const Icon(Icons.android, color: Colors.transparent),
        ),
        titleSpacing: -40,
        centerTitle: false,
        backgroundColor: const Color(0xFF090C22),
        title: const Text('HEALTH METRICS'),
        actions: [
          IconButton(
              onPressed: () {
                AwesomeDialog(
                  dialogBackgroundColor: const Color.fromARGB(255, 24, 32, 68),
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.rightSlide,
                  title: 'Are you sure want to logout?',
                  titleTextStyle: const TextStyle(fontSize: 16, height: 3),
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();

                    await Navigator.pushReplacementNamed(context, '/');
                  },
                ).show();
              },
              icon: const Icon(
                Icons.logout,
                size: 28,
              ))
        ],
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
                'Select Your Gender',
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
                          selectedGender = Gender.male;
                          InputPage.gender = Gender.male;
                          Future.delayed(const Duration(milliseconds: 100))
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HeightAndWeightCheckPage(),
                                  )));
                        });
                      },
                      color: selectedGender == Gender.male
                          ? cActiveCardColor
                          : kInactiveCardColor,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.mars,
                        label: 'MALE',
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
                    selectedGender = Gender.female;
                    InputPage.gender = Gender.female;
                    Future.delayed(const Duration(milliseconds: 500))
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HeightAndWeightCheckPage(),
                            )));
                  });
                },
                color: selectedGender == Gender.female
                    ? cActiveCardColor
                    : kInactiveCardColor,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.venus,
                  label: 'FEMALE',
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
