import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/sign_up.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:flutter_application_3/screen/log_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  Function logout;
  Profile(this.logout);

  @override
  _ProfileState createState() => _ProfileState(this.logout);
}

class _ProfileState extends State<Profile> {
  Function logout;
  _ProfileState(this.logout);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  User1 _userData = User1();
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  XFile? _signatureFile;
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    await CallStorage().getUserData().then((value) {
      setState(() {
        _userData = value;
        isLoading = false;
        _namaController.text = _userData.name!;
        _emailController.text = _userData.email!;
      });
    });
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _imageFile = image;
    });
  }

  _signatureFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _signatureFile = image;
    });
  }

  void deleteAvatar() {
    setState(() {
      _userData.avatar = '';
      _imageFile = null;
    });
  }

  void updateProfile() {
    if (_namaController.text.length < 1) {
      Fluttertoast.showToast(msg: 'Nama tidak boleh kosong');
      return;
    }
    if (_emailController.text.length < 1) {
      Fluttertoast.showToast(msg: 'Email tidak boleh kosong');
      return;
    }
    if (_passwordController.text.length < 8) {
      Fluttertoast.showToast(msg: 'password kurang dari 8 karakter');
      return;
    }
    CallApi()
        .updateProfile(_namaController.text, _emailController.text,
            _passwordController.text, _imageFile!, _signatureFile!)
        .then((value) {
      if (value == 'success') {
        Fluttertoast.showToast(
            msg: 'Success Update Profile', timeInSecForIosWeb: 2);
        initState();
        ;
      } else if (value == 'failed') {
        Fluttertoast.showToast(
            msg: 'Gagal Update Profile', timeInSecForIosWeb: 2);
      } else {
        Fluttertoast.showToast(msg: value, timeInSecForIosWeb: 2);
      }
    });
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
            Stack(
              children: [
                Image.asset(
                  'assets/images/header_home.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                _userData.app == 'admin'
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 50.0,
                          left: 25,
                        ),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            )),
                      )
                    : Container()
              ],
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(65)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(65),
                    child: _imageFile != null
                        ? Image.file(
                            File(_imageFile!.path),
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: _userData.avatar ?? '-',
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
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _imgFromGallery();
                        },
                        child: Text(
                          'Ganti',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ),
                      Text(
                        '  |  ',
                        style: TextStyle(color: Colors.grey[300], fontSize: 23),
                      ),
                      InkWell(
                        onTap: () {
                          deleteAvatar();
                        },
                        child: Text(
                          'Hapus',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
                  left: 33, right: 33, top: 20, bottom: 20),
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
            _userData.app == 'admin'
                ? Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 33),
                          child: Row(
                            children: [
                              Text(
                                'Jabatan',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              )
                            ],
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
                                _userData.position ?? '-',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
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
                  left: 33, right: 33, top: 20, bottom: 10),
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
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
                  left: 33, right: 33, top: 20, bottom: 33),
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.black54),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      )),
                ),
              ),
            ),
            _userData.app == 'admin'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 33, bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              'Tanda Tangan',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 33, right: 33, bottom: 50),
                        child: InkWell(
                          onTap: () {
                            _signatureFromGallery();
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Upload File',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(left: 33, right: 33, bottom: 20),
              child: InkWell(
                onTap: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return Profile();
                  // }));
                },
                child: InkWell(
                  onTap: () {
                    updateProfile();
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33, right: 33, bottom: 30),
              child: InkWell(
                onTap: () {
                  CallStorage().logout();
                },
                child: InkWell(
                  onTap: () {
                    logout();
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
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
