import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'input_page.dart';
import 'otp.dart';
import 'phone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  bool isLogin =
      prefs.containsKey('isLogin') && prefs.getBool('isLogin') == true;
  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  MyApp({required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isLogin ? 'input' : '/',
      routes: {
        '/': (context) => const MyPhone(),
        'otp': (context) => const MyOtp(),
        'input': (context) => InputPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF090C22),
        scaffoldBackgroundColor: const Color(0xFF090C22),
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
