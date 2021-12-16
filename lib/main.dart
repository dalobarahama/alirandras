// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_3/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Air Deras',
    debugShowCheckedModeBanner: false,

    home: SplashScreen(),
    //home: Form_pendaftaran(),
  ));
}
