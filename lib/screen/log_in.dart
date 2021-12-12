import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/screen/forgot_password.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:flutter_application_3/screen/user/main_menu_screen.dart';
import 'package:flutter_application_3/screen/admin/main_menu_screen_admin.dart';
import 'package:flutter_application_3/screen/reset_password.dart';
import 'package:flutter_application_3/screen/sign_up.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Log_in extends StatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  _Log_inState createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  User _userData = User();

  @override
  login() async {
    setState(() {
      isLoading = true;
    });
    await CallApi()
        .login(_emailController.text, _passwordController.text)
        .then((value) {
      setState(() {
        // print('qqqwqwq');
        //print(value);

        print(value);

        if (value == 'success') {
          Timer(Duration(seconds: 1), () {
            CallStorage().getUserData().then((value) {
              setState(() {
                _userData = value;
                if (_userData.app == 'mobile user') {
                  //go to user home screen
                  Navigator.pushReplacement(
                      context, SlideToLeftRoute(page: MainMenuScreen()));
                } else {
                  //go to admin home screen
                  Navigator.pushReplacement(
                      context, SlideToLeftRoute(page: MainMenuScreenAdmin()));
                }
                isLoading = false;
              });
            });
          });
        } else if (value == 'failed') {
          CallStorage().logout();
          Navigator.pushReplacement(
              context, SlideToRightRoute(page: Sign_up()));

          isLoading = false;
        } else {
          Fluttertoast.showToast(msg: value);

          isLoading = false;
        }
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
    //print('wwww');
    //print(isError);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white70),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        height: 150,
                        child: Image.asset(
                          'assets/images/logo_1.png',
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
                          'Log In',
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
                        left: 33, right: 33, top: 20, bottom: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      controller: _emailController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text(
                          'Password',
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
                        left: 33, right: 33, top: 20, bottom: 30),
                    child: TextFormField(
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
                        login();
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white70,
                                )
                              : Text(
                                  'Log In',
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 97),
                        child: Text(
                          'Lupa password?',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Forgot_password();
                          }));
                        },
                        child: Text(
                          ' Reset Password',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/footer_login.png'),
                          fit: BoxFit.cover))),
            )
          ],
        ),
      ),
    );
  }
}
