import 'constants.dart';
import 'reusable_card.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String? bmi;
  final String? result;
  final String? interpretation;

  const ResultsPage({
    this.bmi,
    this.result,
    this.interpretation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HEALTH METRICS'),
          
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Container(
                    child: Center(
              child: Text(
                'Your Result',
                style: kTitleTextStyle,
              ),
            ))),
            Expanded(
                flex: 5,
                child: ReusableCard(
                  color: kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        result!.toUpperCase(),
                        style: kResultTextStyle,
                      ),
                      Text(
                        bmi!,
                        style: kBMITextStyle,
                      ),
                      Text(
                        interpretation!,
                        textAlign: TextAlign.center,
                        style: kBodyTextStyle,
                      )
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Center(
                  child: Text(
                    'RE-CALCULATE',
                    style: kLargeButtonTextStyle,
                  ),
                ),
                padding: EdgeInsets.only(bottom: 20.0),
                color: kBottomContainerColor,
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: kBottomContainerHeight,
              ),
            ),
          ],
        ));
  }
}
