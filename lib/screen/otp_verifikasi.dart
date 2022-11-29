import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/screen/reset_password.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../utils/color_pallete.dart';

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
  // StreamController<ErrorAnimationType> errorController = StreamController();
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
    const borderColor = ColorPallete.mainColor;
    var fillColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ColorPallete.mainBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 30,
                top: 30,
                right: 30,
              ),
              child: Text(
                'Masukkan kode OTP yang tertera pada email Anda',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 30,
                left: 30,
              ),
              child: Pinput(
                controller: _otpController,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: borderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: borderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: borderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: InkWell(
                onTap: () {
                  // verifikasi_otp();
                  Navigator.push(
                      context,
                      SlideToRightRoute(
                          page: Reset_password(_otpController.text)));
                  Fluttertoast.showToast(msg: _otpController.text);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorPallete.mainColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: isLoading == true
                        ? const Center(
                            child: SizedBox(
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
                                fontSize: 16,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                resend_otp();
              },
              child: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  'Kirim ulang kode OTP',
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textStyle: const TextStyle(
                        color: ColorPallete.mainColor,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
