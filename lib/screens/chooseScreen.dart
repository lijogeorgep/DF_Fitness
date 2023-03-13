import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:df_fitness/screens/bottomNavigationScreen.dart';
import 'package:df_fitness/screens/onBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({super.key});

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  bool? loginStatus;
  @override
  void initState() {
    super.initState();
    var FirebaseAuth;
    if (FirebaseAuth?.instance.currentUser != null) {
      debugPrint('Already logged in');
      setState(() {
        loginStatus = true;
      });
    } else {
      setState(() {
        loginStatus = false;
      });
      debugPrint('not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return loginStatus == true
        ? const BottomNavigationScreen()
        : AnimatedSplashScreen(
            duration: 3000,
            splash: 'assets/logo.png',
            splashIconSize: 850.0,
            nextScreen: const OnBoardingScreen(),
            splashTransition: SplashTransition.scaleTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.white);
  }
}
