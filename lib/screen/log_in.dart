import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/screen/forgot_password.dart';
import 'package:flutter_application_3/screen/user/main_menu_screen.dart';
import 'package:flutter_application_3/screen/admin/main_menu_screen_admin.dart';
import 'package:flutter_application_3/screen/sign_up.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
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
  User1 _userData = User1();

  login() async {
    setState(() {
      isLoading = true;
    });
    await CallApi()
        .login(_emailController.text, _passwordController.text)
        .then((value) {
      setState(() {
        print(value);

        if (value == 'success') {
          Timer(const Duration(seconds: 1), () {
            CallStorage().getUserData().then((value) {
              setState(() {
                _userData = value;
                if (_userData.app == 'mobile user') {
                  //go to user home screen
                  Navigator.pushReplacement(
                      context, SlideToLeftRoute(page: const MainMenuScreen()));
                } else {
                  //go to admin home screen
                  Navigator.pushReplacement(context,
                      SlideToLeftRoute(page: const MainMenuScreenAdmin()));
                }
                isLoading = false;
              });
            });
          });
        } else if (value == 'failed') {
          CallStorage().logout();
          Navigator.pushReplacement(
              context, SlideToRightRoute(page: const Sign_up()));

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.mainBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Text(
                        'Sign In',
                        style: GoogleFonts.roboto(
                          fontSize: 36,
                          textStyle: const TextStyle(
                              color: ColorPallete.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          textStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 12,
                    bottom: 20,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan email',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black26,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: _emailController,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Password',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          textStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 12,
                    bottom: 30,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan password',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black26,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: _passwordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 30,
                  ),
                  child: InkWell(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorPallete.mainColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Sign In',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Lupa password?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Forgot_password();
                        }));
                      },
                      child: const Text(
                        ' Reset Password',
                        style: TextStyle(
                          color: ColorPallete.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
