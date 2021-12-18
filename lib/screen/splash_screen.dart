import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/screen/admin/main_menu_screen_admin.dart';
import 'package:flutter_application_3/screen/log_in.dart';
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
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  firebaseSetup() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    await FirebaseMessaging.instance.subscribeToTopic('notification');

    messaging.getToken().then((token) {
      CallStorage().checkIfLoggedIn().then((value) {
        if (value) {
          CallAdminApi().updateFCM(token!).then((value) {
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
        } else {
          Navigator.pushReplacement(context, SlideToLeftRoute(page: Sign_up()));
        }
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  void initState() {
    Timer(Duration(seconds: 1), () {
      //Navigator.pushReplacement(context, SlideToLeftRoute(page: Sign_up()));

      firebaseSetup();
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
