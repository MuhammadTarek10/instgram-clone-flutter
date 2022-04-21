import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instgramclone/firebase_options.dart';
import 'package:instgramclone/responsive/mobile_screen_layout.dart';
import 'package:instgramclone/responsive/responsive_screen_layout.dart';
import 'package:instgramclone/responsive/web_screen_layout.dart';
import 'package:instgramclone/screens/login_screen.dart';
import 'package:instgramclone/screens/signup_screen.dart';
import 'package:instgramclone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instgram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveScreenLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      home: const SignupScreen(),
    );
  }
}
