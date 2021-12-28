import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/models/manajemen_pengguna_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditManajemenPenggunaScreen extends StatefulWidget {
  Pengguna _dataPengguna;
  EditManajemenPenggunaScreen(this._dataPengguna);

  @override
  _EditManajemenPenggunaScreenState createState() =>
      _EditManajemenPenggunaScreenState(this._dataPengguna);
}

class _EditManajemenPenggunaScreenState
    extends State<EditManajemenPenggunaScreen> {
  Pengguna _dataPengguna;
  _EditManajemenPenggunaScreenState(this._dataPengguna);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _jabatanController = TextEditingController();

  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _avatarFile;
  XFile? _signatureFile;
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    setState(() {
      isLoading = false;
      _namaController.text = _dataPengguna.name!;
      _emailController.text = _dataPengguna.email!;
      if (_dataPengguna.position != null) {
        _jabatanController.text = _dataPengguna.position!;
      }
    });
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _avatarFile = image;
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
      _dataPengguna.avatar = '';
      _avatarFile = null;
    });
  }

  void editManajemen() {
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
        Fluttertoast.showToast(msg: 'password kurang dari 8 karakter');
        return;
      }
    }
    if (_dataPengguna.app == 'admin') {
      if (_jabatanController.text.length < 1) {
        Fluttertoast.showToast(msg: 'Jabatan tidak boleh kosong');
        return;
      }
    }
    CallAdminApi()
        .editManajemenPengguna(
            _namaController.text,
            _emailController.text,
            _passwordController.text,
            _avatarFile,
            _signatureFile,
            _dataPengguna.id.toString())
        .then((value) {
      if (value == 'success') {
        Fluttertoast.showToast(
            msg: 'Success Update Profile', timeInSecForIosWeb: 2);
        Timer(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else if (value == 'failed') {
        Fluttertoast.showToast(
            msg: 'Gagal Update Profile', timeInSecForIosWeb: 2);
      } else {
        Fluttertoast.showToast(msg: value, timeInSecForIosWeb: 2);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
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
                        color: Colors.red,
                        size: 30,
                      )),
                )
              ],
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
                    child: _avatarFile != null
                        ? Image.file(
                            File(_avatarFile!.path),
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: _dataPengguna.avatar ?? '-',
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
            _dataPengguna.app == 'admin'
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
                                  controller: _jabatanController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  )),
                            ),
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
                    editManajemen();
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
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
