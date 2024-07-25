import 'package:bmi_flutter/input_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String? bmi;
  final String? result;
  final String? interpretation;
  final String description;
  final String disease;

  const ResultsPage({
    this.bmi,
    this.result,
    this.interpretation,
    Key? key,
    required this.description,
    required this.disease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputPage(),
                    ));
              },
              icon: const Icon(
                Icons.close,
                size: 28,
              )),
          backgroundColor: const Color(0xFF090C22),
          elevation: 0,
          title: Text(
            'Result',
            style: GoogleFonts.lato(fontSize: 22),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 5),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 20),
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
                    Text('RE - CALCULATE',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato', // Set the text color to white
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputPage(),
                      ));
                },
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 60, 70, 106)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'BMI  -  ',
                            style: GoogleFonts.lato(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(width: 10,),
                          Text(bmi!,
                              style: GoogleFonts.lato(
                                  fontSize: 35, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                result!.toUpperCase(),
                style: GoogleFonts.lato(
                    fontSize: 40,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              if (disease != '')
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        disease.toUpperCase(),
                        style: GoogleFonts.lato(
                            fontSize: 25,
                            color: const Color.fromARGB(255, 255, 116, 106),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  interpretation!,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    height: 1.7,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
