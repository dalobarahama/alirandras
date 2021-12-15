import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:flutter_application_3/screen/user/main_menu_screen.dart';
import 'log_in.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  bool isLoading = false;
  @override
  register() async {
    setState(() {
      isLoading = true;
    });
    await CallApi()
        .register(_namaController.text, _emailController.text,
            _passwordController.text)
        .then((value) {
      setState(() {
        print(value);
        if (value == 'success') {
          Fluttertoast.showToast(msg: 'Berhasil Registrasi');
          Timer(Duration(seconds: 2), () {
            Navigator.pushReplacement(
                context, SlideToLeftRoute(page: Log_in()));
          });
        } else if (value == 'failed') {
          Fluttertoast.showToast(msg: 'Terjadi kesalahan');
          setState(() {
            isLoading = false;
          });
        } else {
          Fluttertoast.showToast(msg: value);
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white70),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Container(
                      height: 150,
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Text(
                        'Sign Up',
                        style: GoogleFonts.roboto(
                            fontSize: 24,
                            textStyle: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text(
                        'Nama',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            textStyle: TextStyle(
                              color: Colors.grey[500],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 33, top: 10, bottom: 20),
                  child: TextFormField(
                    style: TextStyle(
                      height: 0.8,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: _namaController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            textStyle: TextStyle(
                              color: Colors.grey[500],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 33, right: 33, top: 10, bottom: 20),
                  child: TextFormField(
                    style: TextStyle(
                      height: 0.8,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: _emailController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33),
                  child: Row(
                    children: [
                      Text(
                        'Password',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            textStyle: TextStyle(
                              color: Colors.grey[500],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 33, right: 33, top: 10, bottom: 30),
                  child: TextFormField(
                    style: TextStyle(
                      height: 0.8,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: _passwordController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 33, right: 33, bottom: 30),
                  child: InkWell(
                    onTap: () {
                      register();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.white70,
                            ))
                          : Center(
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: TextStyle(color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Log_in();
                        }));
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/footer_login.png'),
                              fit: BoxFit.cover))),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
