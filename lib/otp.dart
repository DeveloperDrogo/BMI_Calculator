// ignore_for_file: use_build_context_synchronously

import 'package:bmi_flutter/phone.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 54,
      height: 54,
      textStyle: const TextStyle(
          fontSize: 20,
          //color: Color(0xff597AAB),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 33, 41, 79),
        border: Border.all(
            width: 1, color: const Color.fromARGB(255, 102, 102, 183)),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      //color: Colors.white,
      border: Border.all(color: const Color.fromARGB(255, 176, 176, 255)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          // color: const Color.fromARGB(255, 252, 254, 255),
          ),
    );

    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/logo.png',
                width: 130,
                height: 130,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 20),
                    child: SizedBox(
                      height: 38,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          // fontStyle: FontStyle.italic
                        ),
                        child: Text('HealthMetrics',
                            style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 0),
                    child: Text('Health living guide for you',
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 150, 150, 150),
                          //fontStyle: FontStyle.italic
                        ))),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 120),
                    child: Text("OTP",
                        style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                fontFamily: 'Lato',
                                // color: Color(0xff495F81),
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w600))),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 0, top: 8),
                      child: RichText(
                          text: TextSpan(
                              text: "Enter the OTP sent to  ",
                              style: const TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color.fromARGB(255, 204, 204, 204)),
                              children: [
                            TextSpan(
                                text: MyPhone.completeNumber,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))
                          ])))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onChanged: (value) => code = value,
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: MyPhone.verify, smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLogin', true);

                      Navigator.pushNamedAndRemoveUntil(
                          context, 'input', (route) => false);
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Error",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            content: const Text(
                              "Wrong OTP",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      );
                    }
                  },
                  // ignore: sort_child_properties_last
                  child: Row(
                    children: [
                      Text('CONTINUE',
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
