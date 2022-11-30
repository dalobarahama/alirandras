import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/screen/otp_verifikasi.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
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
              padding: const EdgeInsets.only(
                left: 30,
                top: 30,
                right: 30,
              ),
              child: Text(
                'Kami akan mengirimkan panduan reset password ke email Anda',
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
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
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
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: InkWell(
                onTap: () {
                  forgot_email();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorPallete.mainColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
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
          ],
        ),
      ),
    );
  }
}
