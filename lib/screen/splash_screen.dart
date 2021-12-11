import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/screen/admin/main_menu_screen_admin.dart';
import 'package:flutter_application_3/screen/user/main_menu_screen.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/screen/sign_up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 1), () {
      //Navigator.pushReplacement(context, SlideToLeftRoute(page: Sign_up()));
      CallStorage().checkIfLoggedIn().then((value) {
        CallStorage().getUserData().then((value) {
          setState(() {
            if (value.app == 'mobile user') {
              //go to user home screen
              Navigator.pushReplacement(
                  context, SlideToLeftRoute(page: MainMenuScreen()));
            } else {
              //go to admin home screen
              Navigator.pushReplacement(
                  context, SlideToLeftRoute(page: MainMenuScreenAdmin()));
            }
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white70),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
