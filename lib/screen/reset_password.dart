import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:flutter_application_3/screen/log_in.dart';
import 'package:flutter_application_3/screen/user/main_menu_screen.dart';
import 'package:flutter_application_3/screen/otp_verifikasi.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Reset_password extends StatefulWidget {
  String code = '';
  Reset_password(this.code);

  @override
  _Reset_passwordState createState() => _Reset_passwordState(this.code);
}

class _Reset_passwordState extends State<Reset_password> {
  String code = '';
  _Reset_passwordState(this.code);
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  bool isLoading = false;
  reset_password() async {
    setState(() {
      isLoading = true;
    });
    if (_passwordController.text == _confirmpasswordController.text) {
      await CallApi()
          .reset_password(code, _passwordController.text)
          .then((value) {
        setState(() {
          isLoading = false;
          print(value);
          if (value == 'success') {
            Fluttertoast.showToast(
                msg: 'Berhasil Reset Password', timeInSecForIosWeb: 2);
            Navigator.push(context, SlideToRightRoute(page: Log_in()));
          } else if (value == 'failed') {
            setState(() {
              isLoading = false;
              Fluttertoast.showToast(
                  msg: 'Terjadi Kesalahan', timeInSecForIosWeb: 2);
            });
          } else {
            Fluttertoast.showToast(msg: value, timeInSecForIosWeb: 2);
          }
        });
      }).catchError((e) {
        setState(() {
          isLoading = false;
          Fluttertoast.showToast(msg: e, timeInSecForIosWeb: 2);
        });
      });
    } else {
      Fluttertoast.showToast(
          msg: 'Password tidak sama, coba lagi', timeInSecForIosWeb: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 30),
              child: Row(
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
                      'Reset Password',
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
                      'Reset Password Anda',
                      style: GoogleFonts.roboto(
                          fontSize: 20,
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
                    'New Password',
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
                decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                controller: _passwordController,
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
                    'Confirm Password',
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
                  left: 33, right: 32, top: 18, bottom: 33),
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                controller: _confirmpasswordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33, right: 32, bottom: 30),
              child: InkWell(
                onTap: () {
                  reset_password();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Save',
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
          ],
        ),
      ),
    );
  }
}
