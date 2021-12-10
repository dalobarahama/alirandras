import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:flutter_application_3/screen/log_in.dart';
import 'package:flutter_application_3/screen/otp_verifikasi.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgot_password extends StatefulWidget {
  const Forgot_password({Key? key}) : super(key: key);

  @override
  _Forgot_passwordState createState() => _Forgot_passwordState();
}

class _Forgot_passwordState extends State<Forgot_password> {
  TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  forgot_email() async {
    setState(() {
      isLoading = true;
    });
    await CallApi().cek_email(_emailController.text).then((value) {
      setState(() {
        isLoading = false;
        print(value);
        if (value == 'success') {
          setState(() {
            isLoading = false;
          });
          Navigator.push(context,
              SlideToRightRoute(page: Otp_verifikasi(_emailController.text)));
        } else if (value == 'failed') {
          setState(() {
            isLoading = false;
            Fluttertoast.showToast(
                msg: 'Terjadi Kesalahan', timeInSecForIosWeb: 2);
          });
        } else {
          Fluttertoast.showToast(msg: value);
        }
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(msg: e);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.lightBlue[300],
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27, top: 45),
                  child: Container(
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.roboto(
                          fontSize: 33,
                          fontWeight: FontWeight.w400,
                          textStyle: TextStyle(
                            color: Colors.grey[600],
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27, top: 30),
                  child: Container(
                    child: Text(
                      'Kami akan mengirimkan kode OTP ke ',
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          textStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 27,
                  ),
                  child: Container(
                    child: Text(
                      'email anda ',
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          textStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 33, right: 32, top: 15, bottom: 18),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Masukkan email anda',
                  hintStyle: GoogleFonts.roboto(
                      fontSize: 15,
                      textStyle: TextStyle(
                        color: Colors.grey[500],
                      )),
                  fillColor: Colors.grey[300],
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 33, right: 32, bottom: 30, top: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Otp_verifikasi(_emailController.text);
                  }));
                },
                child: InkWell(
                  onTap: () {
                    forgot_email();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8)),
                    child: isLoading == true
                        ? Center(
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Submit',
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
            ),
          ],
        ),
      ),
    );
  }
}
