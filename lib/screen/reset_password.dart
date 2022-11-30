import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/color_pallete.dart';

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
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
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
      backgroundColor: ColorPallete.mainBackgroundColor,
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
        centerTitle: true,
        backgroundColor: ColorPallete.mainBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                left: 30,
                top: 30,
                right: 30,
              ),
              child: Text(
                'Masukkan password baru Anda',
                textAlign: TextAlign.start,
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
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text(
                    'Password baru',
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
                top: 10,
              ),
              child: TextFormField(
                style: const TextStyle(
                  height: 0.8,
                ),
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
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text(
                    'Konfirmasi password baru',
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
                top: 10,
                bottom: 30,
              ),
              child: TextFormField(
                style: const TextStyle(
                  height: 0.8,
                ),
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Konfirmasi password',
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
                controller: _confirmpasswordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 20,
              ),
              child: InkWell(
                onTap: () {
                  reset_password();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorPallete.mainColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: Center(
                    child: Text(
                      'Reset Password',
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
          ],
        ),
      ),
    );
  }
}
