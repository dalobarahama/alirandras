import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/sign_up.dart';
import 'package:flutter_application_3/screen/home_screen.dart';
import 'package:flutter_application_3/screen/log_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  User _userData = User();
  bool isLoading = true;
  @override
  void initState() {
    setState(() {
      Timer(Duration(seconds: 1), () {
        CallStorage().getUserData().then((value) {
          setState(() {
            _userData = value;
            isLoading = false;
            _namaController.text = _userData.name!;
            _emailController.text = _userData.email!;
          });
        });
      });
    });
    super.initState();
  }

  /* void updateData() async {
    setState(() {
      isLoading = true;
    });
    await CallApi()
        .updateProfile(_nameController.text, _emailController.text,
            _passwordController.text)
        .then((value) {
      if (value) {
        Fluttertoast.showToast(msg: 'Success');
        CallApi()
            .login(_emailController.text, _passwordController.text)
            .then((value) {
          Navigator.pop(context, 'refresh');
        });
      } else {
        Fluttertoast.showToast(
            msg: 'Silahkan masukkan email, nama dan password terlebih dahulu.');
      }
      setState(() {
        isLoading = false;
      });
    });
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.lightBlue, Colors.white])),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33, top: 5),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      'Profil',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(65)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(65),
                      child: CachedNetworkImage(
                        imageUrl: _userData.signature!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 143, top: 15),
                    child: Center(
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              'Ganti',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                            ),
                            Text(
                              '  |  ',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 23),
                            ),
                            Text(
                              'Hapus',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33),
              child: Row(
                children: [
                  Text(
                    'Nama',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 33, right: 32, top: 15, bottom: 18),
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      style: TextStyle(color: Colors.black54),
                      controller: _namaController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.grey[300],
                          filled: true)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33),
              child: Row(
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 33, right: 32, top: 15, bottom: 15),
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      style: TextStyle(color: Colors.black54),
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33),
              child: Row(
                children: [
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 33, right: 32, top: 18, bottom: 33),
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      style: TextStyle(color: Colors.black54),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '********',
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Colors.black54,
                        ),
                        border: InputBorder.none,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33, right: 32, bottom: 15),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Profile();
                  }));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33, right: 32, bottom: 30),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Log_in();
                  }));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.red, fontSize: 20),
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
