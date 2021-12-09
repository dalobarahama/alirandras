import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/screen/forgot_password.dart';
import 'package:flutter_application_3/screen/log_in.dart';
import 'package:flutter_application_3/screen/reset_password.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otp_verifikasi extends StatefulWidget {
  String email = '';
  Otp_verifikasi(this.email);

  @override
  _Otp_verifikasiState createState() => _Otp_verifikasiState(this.email);
}

class _Otp_verifikasiState extends State<Otp_verifikasi> {
  String email = '';
  _Otp_verifikasiState(this.email);
  TextEditingController _otpController = TextEditingController();
  String currentText = "";
  StreamController<ErrorAnimationType> errorController = StreamController();
  bool isLoading = false;
  verifikasi_otp() async {
    setState(() {
      isLoading = true;
    });
    await CallApi().verifikasi_otp(_otpController.text).then((value) {
      setState(() {
        isLoading = false;
        print(value);
        if (value == 'success') {
          Navigator.push(context,
              SlideToRightRoute(page: Reset_password(_otpController.text)));
        } else if (value == 'failed') {
          Fluttertoast.showToast(
              msg: 'Terjadi Kesalahan', timeInSecForIosWeb: 2);
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

  resend_otp() async {
    setState(() {
      isLoading = true;
    });
    await CallApi().cek_email(email).then((value) {
      setState(() {
        isLoading = false;
        print(value);
        if (value == 'success') {
          setState(() {
            isLoading = false;
          });
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
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: Row(
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Forgot_password();
                        }));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.lightBlue[300],
                        size: 40,
                      ),
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
                      'OTP Verification',
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
                      'Masukkan kode OTP yang telah dikirim ke',
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
                    'Masukkan kode OTP',
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        textStyle: TextStyle(
                          color: Colors.grey[500],
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 50, left: 40),
              child: Container(
                child: Column(
                  children: [
                    PinCodeTextField(
                      appContext: context,
                      keyboardType: TextInputType.number,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 60,
                          fieldWidth: 60,
                          activeFillColor: Colors.grey[200],
                          activeColor: Colors.grey[200],
                          disabledColor: Colors.grey[200],
                          inactiveColor: Colors.grey[200],
                          selectedColor: Colors.grey[200],
                          inactiveFillColor: Colors.grey[200],
                          selectedFillColor: Colors.grey[200]),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: _otpController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 33, right: 33, bottom: 30, top: 40),
              child: InkWell(
                onTap: () {
                  verifikasi_otp();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: isLoading == true
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Verifikasi',
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27, top: 20),
                  child: InkWell(
                    onTap: () {
                      resend_otp();
                    },
                    child: Container(
                      child: Text(
                        'Resend kode ',
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            textStyle: TextStyle(
                              color: Colors.red,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
