// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/admin/home_screen_admin.dart';
import 'package:flutter_application_3/screen/profile.dart';
import 'package:flutter_application_3/screen/user/cek_status_pengajuan.dart';
import 'package:flutter_application_3/screen/user/detail_card_statuspengajuan.dart';
import 'package:flutter_application_3/screen/forgot_password.dart';
import 'package:flutter_application_3/screen/otp_verifikasi.dart';
import 'package:flutter_application_3/screen/reset_password.dart';
import 'package:flutter_application_3/screen/user/form_pendaftaran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/screen/test_listview.dart';
import 'package:flutter_application_3/screen/splash_screen.dart';
import 'package:flutter_application_3/screen/admin/main_menu_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/setting_surat_pengajuan_screen_admin.dart';

void main() {
  runApp(MaterialApp(
    title: 'Air Deras',
    debugShowCheckedModeBanner: false,

    //home: SplashScreen(),
    home: Form_pendaftaran(),
  ));
}
