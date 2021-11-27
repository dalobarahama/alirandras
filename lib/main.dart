// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/screen/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Air Deras',
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
