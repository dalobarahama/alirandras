import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController _jabatanController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  User1 _userData = User1();
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  XFile? _signatureFile;
  String? signatureFromUrl;

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    isLoading = true;
    await CallStorage().getUserData().then((value) {
      print("profile value: ${value.name}");
      print("profile signature: ${value.signature}");
      print("profile signatureFile: $_signatureFile");
      _userData = value;
      _namaController.text = value.name!;
      _emailController.text = value.email!;
      if (value.app == 'admin') {
        if (value.signature != null) {
          signatureFromUrl = _userData.signature!;
        }
        if (value.position != null) {
          _jabatanController.text = _userData.position;
        }
      }
      setState(() {
        isLoading = false;
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
    if (_passwordController.text.length > 0) {
      if (_passwordController.text.length < 8) {
        Fluttertoast.showToast(
            msg: 'Password tidak boleh Kurang dari 8 karakter');
        return;
      }
    }

    setState(() {
      isLoading = true;
    });

    CallApi()
        .updateProfile(_namaController.text, _emailController.text,
            _passwordController.text, _imageFile, _signatureFile)
        .then((value) {
      if (value == 'success') {
        Fluttertoast.showToast(
            msg: 'Success Update Profile', timeInSecForIosWeb: 2);
        initData();
      } else if (value == 'failed') {
        Fluttertoast.showToast(
            msg: 'Gagal Update Profile', timeInSecForIosWeb: 2);
      } else {
        Fluttertoast.showToast(msg: value, timeInSecForIosWeb: 2);
      }
      isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.mainBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/images/header_new.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: -50,
                  right: 135,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorPallete.mainColor,
                      borderRadius: BorderRadius.circular(65),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(65),
                      child: _imageFile != null
                          ? Image.file(
                              File(_imageFile!.path),
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: _userData.avatar ?? '-',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                  'assets/images/default_profile_pic.png'),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _imgFromGallery();
                        },
                        child: const Text(
                          'Ganti',
                          style: TextStyle(
                            color: ColorPallete.mainColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        '  |  ',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 24,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          deleteAvatar();
                        },
                        child: Text(
                          'Hapus',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30),
              child: const Text(
                'Nama',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 12,
              ),
              child: TextFormField(
                style: const TextStyle(
                  height: 0.8,
                ),
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.edit_outlined,
                    size: 20,
                  ),
                  hintText: 'Masukkan nama',
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
                controller: _namaController,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _userData.app == 'admin'
                ? Container(
                    margin: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 30),
                          child: const Text(
                            'Jabatan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 12,
                          ),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                _jabatanController.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30),
              child: const Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
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
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.edit_outlined,
                    size: 20,
                  ),
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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30),
              child: const Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
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
                  suffixIcon: Icon(
                    Icons.edit_outlined,
                    size: 20,
                  ),
                  hintText: '********',
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
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: InkWell(
                onTap: () {
                  updateProfile();
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
                            'Update',
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
            InkWell(
              onTap: () {
                logout();
                CallStorage().logout();
              },
              child: const SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: ColorPallete.mainColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
