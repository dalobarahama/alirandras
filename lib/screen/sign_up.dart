import 'dart:async';

import 'package:flutter/material.dart';
import '../utils/color_pallete.dart';
import 'log_in.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
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
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
                context, SlideToLeftRoute(page: const Log_in()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallete.mainBackgroundColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                            'Sign Up',
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
                            'Nama',
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
                        style: const TextStyle(
                          height: 0.8,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Masukkan nama',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                          ),
                          fillColor: Colors.grey[300],
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        controller: _namaController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 10,
                        bottom: 20,
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                          height: 0.8,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Masukkan email',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                          ),
                          fillColor: Colors.grey[300],
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        controller: _emailController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 10,
                        bottom: 30,
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                          height: 0.8,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Masukkan password',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                          ),
                          fillColor: Colors.grey[300],
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        controller: _passwordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 33, right: 33, bottom: 30),
                      child: InkWell(
                        onTap: () {
                          register();
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorPallete.mainColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : Center(
                                  child: Text(
                                    'Sign Up',
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
                      children: [
                        const Text(
                          'Sudah punya akun?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const Log_in();
                            }));
                          },
                          child: const Text(
                            ' Login',
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
        ));
  }
}
