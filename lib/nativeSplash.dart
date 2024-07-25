import 'package:bmi_flutter/input_page.dart';
import 'package:bmi_flutter/phone.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenPage extends StatefulWidget {
  final bool login;
  const SplashScreenPage({super.key, required this.login});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

 @override
  void initState() {
    super.initState();
    // Navigate to the next page after 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.login?InputPage():const MyPhone()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                height: 200, width: 200, child: Image.asset('assets/logo.png')),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'HEALTH METRICS',
            style: GoogleFonts.aDLaMDisplay(fontSize: 28),
          )
        ],
      ),
    );
  }
}
