import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/forgot_password.dart';
import 'package:flutter_application_3/screen/home_screen.dart';
import 'package:flutter_application_3/screen/main_menu_screen.dart';
import 'package:flutter_application_3/screen/reset_password.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:google_fonts/google_fonts.dart';

class Log_in extends StatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  _Log_inState createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Colors.white70),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
                controller: _emailController,
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
                  left: 33, right: 32, top: 18, bottom: 33),
              child: TextFormField(
                obscureText: true,
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
            Padding(
              padding: const EdgeInsets.only(left: 33, right: 32, bottom: 30),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context, SlideToLeftRoute(page: MainMenuScreen()));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
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
            Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/footer_login.png'),
                        fit: BoxFit.cover)))
          ],
        ),
      ),
    ));
  }
}
