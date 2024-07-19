import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({super.key});
  static String verify = "";
  static String completeNumber='';

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryCode = TextEditingController();
  var phone = "";

  @override
  void initState() {
    countryCode.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
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
                    padding: const EdgeInsets.only(left: 0, top: 140),
                    child: Text("Login",
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
                    child: Text('Enter the Phone Number',
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                          fontFamily: 'Lato',
                          color: Color.fromARGB(255, 150, 150, 150),
                        ))),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: countryCode,
                        style: const TextStyle(
                          color: Colors
                              .white60, // Change this to your desired color
                        ),
                      ),
                    ),
                    const Text(
                      '|',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) => phone = value,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                        style: const TextStyle(
                          color:
                              Colors.white, // Change this to your desired color
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              10), // Limit to 10 digits
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      MyPhone.completeNumber= countryCode.text + phone;
                    });
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: countryCode.text + phone,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        MyPhone.verify = verificationId;
                        Navigator.pushNamed(context, 'otp');
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('GENERATE OTP',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
