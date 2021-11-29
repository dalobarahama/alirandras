// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/cek_status_pengajuan.dart';
import 'package:flutter_application_3/screen/detail_card_statuspengajuan.dart';
import 'package:flutter_application_3/screen/forgot_password.dart';
import 'package:flutter_application_3/screen/otp_verifikasi.dart';
import 'package:flutter_application_3/screen/reset_password.dart';
import 'package:flutter_application_3/screen/form_pendaftaran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/screen/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Air Deras',
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
