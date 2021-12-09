import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/models/get_kecamatan.dart';
import 'package:flutter_application_3/models/get_kelurahan.dart';
import 'package:flutter_application_3/models/submit_formulir.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:flutter_application_3/screen/user/main_menu_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class Form_pendaftaran extends StatefulWidget {
  const Form_pendaftaran({Key? key}) : super(key: key);

  @override
  _Form_pendaftaranState createState() => _Form_pendaftaranState();
}

class _Form_pendaftaranState extends State<Form_pendaftaran> {
  @override
  TextEditingController _luasBangunanController = TextEditingController();
  TextEditingController _luasLahanController = TextEditingController();
  TextEditingController _lokasiBangunanController = TextEditingController();
  TextEditingController _alamatLengkapController = TextEditingController();
  String jenisPermohonan = '';
  String district = 'BALIKPAPAN KOTA';
  bool isSubmit = false;
  bool isLoading = true;
  bool isLoading1 = false;
  String lat = '';
  String lang = '';
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  List<GetKecamatan> _listKecamatan = <GetKecamatan>[];
  GetKecamatan? _selectedKecamatan = GetKecamatan();
  List<GetKelurahan> _listKelurahan = <GetKelurahan>[];
  GetKelurahan? _selectedKelurahan = GetKelurahan();
  SubmitFormulir _dataFormulir = SubmitFormulir();
  List<File> uploadFiles = <File>[];
  List<bool> isFinish = [
    false,
    false,
    false,
    false
  ]; //0=kec 1=kel 2=upload form 3=upload dok
  List<String> jenis_permohonan = [
    'Surat Informasi',
    'Surat Rekomendasi',
  ];

  initState() {
    _selectedKecamatan = null;
    _selectedKelurahan = null;
    getKecamatan();
    if (isFinish[0] == true) {
      isLoading = false;
    }
    super.initState();
  }

  getKecamatan() async {
    await CallApi().getKecamatan().then((value) {
      setState(() {
        isFinish[0] = true;
        _listKecamatan = value;
      });
    });
  }

  getKelurahan(id) async {
    print(id);
    print('xxx');
    await CallApi().getKelurahan(id).then((value) {
      setState(() {
        isFinish[1] = true;
        _listKelurahan = value;
        print(_listKelurahan[2].name);
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

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        uploadFiles.addAll(result.paths.map((path) => File(path!)).toList());
      });
    } else {
      // User canceled the picker
    }
  }

  submit_formulir() async {
    setState(() {
      isLoading1 = true;
    });
    await CallApi()
        .submit_formulir(
            jenisPermohonan,
            district,
            _selectedKecamatan!.name,
            _luasBangunanController.text,
            _luasLahanController.text,
            _lokasiBangunanController.text,
            _alamatLengkapController.text,
            lat,
            lang)
        .then((value) {
      setState(() {
        _dataFormulir = value;
        if (_dataFormulir != null) {
          if (_dataFormulir.statusCode == 200) {
            isFinish[2] = true;
            submit_gambar(_dataFormulir.registrationForm!.id);
          } else if (_dataFormulir.statusCode! >= 400 &&
              _dataFormulir.statusCode! <= 500) {
            Fluttertoast.showToast(msg: 'Gagal upload data');
          } else {
            Fluttertoast.showToast(msg: _dataFormulir.message!);
          }
        } else {
          Fluttertoast.showToast(msg: 'Terjadi Kesalahan');
        }
      });
    });
  }

  submit_gambar(int? id) async {
    CallApi().submit_gambar(id, _imageFile).then((value) {
      setState(() {
        isLoading1 = false;
        isFinish[3] = true;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15),
                child: Row(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) {
                            return Home();
                          }));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.lightBlue[300],
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 27, top: 10),
                    child: Container(
                      child: Text(
                        'Isi Formulir Pendaftaran',
                        style: GoogleFonts.roboto(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            textStyle: TextStyle(
                              color: Colors.lightBlue,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 230,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jenis Permohonan',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItems: false,
                        items: jenis_permohonan,
                        //  hint: "Pilih Jenis Permohonan",
                        dropdownBuilder: (context, selectedItem) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: Text(
                              selectedItem == null
                                  ? 'Pilih Jenis Permohonan'
                                  : selectedItem,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          );
                        },
                        popupItemBuilder: (context, item, isSelected) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              item,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          );
                        },

                        // dropdownBuilder: _customDropDownExample,
                        dropdownSearchBaseStyle:
                            TextStyle(fontSize: 12.0, color: Colors.black54),

                        onChanged: (value) {
                          setState(() {
                            jenisPermohonan = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kecamatan',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                        width: 215,
                        height: 50,
                        child: _listKecamatan == null
                            ? CircularProgressIndicator()
                            : _buildKecamatanDropdown()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kelurahan',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                        width: 215,
                        height: 50,
                        child: _buildKelurahanDropdown()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Luas Bangunan',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: TextField(
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        controller: _luasBangunanController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Luas Lahan',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: TextField(
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        controller: _luasLahanController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lokasi Bangunan',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: TextField(
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        controller: _lokasiBangunanController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Alamat Lengkap',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: TextField(
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        controller: _alamatLengkapController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gambar Bangunan',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          _imgFromGallery();
                        },
                        child: Container(
                          height: 60,
                          width: 214,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                              child: Text(
                            'Upload File',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                textStyle: TextStyle(
                                  color: Colors.white70,
                                )),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _imageFile != null
                          ? submit_formulir()
                          : isFinish[3] = true;
                      isFinish[3] == true
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 16,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white70,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 70),
                                            Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  'Submit berhasil!',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    SlideToRightRoute(
                                                        page:
                                                            MainMenuScreen())); //ini nanti ubah yang pakai index supaya ga ilang nav bar
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Kembali',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(65),
                                            child: Image.network(
                                              'https://images.unsplash.com/photo-1634901623176-14daf9946560?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=693&q=80',
                                              fit: BoxFit.cover,
                                              height: 70,
                                              width: 70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : Container();
                    });
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: isLoading1 == true
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Submit',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    textStyle: TextStyle(
                                      color: Colors.white70,
                                    )),
                              )),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _buildKecamatanDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(left: 12, right: 24),
      child: DropdownButton<GetKecamatan>(
        style: TextStyle(fontSize: 12, color: Colors.black54),
        onChanged: (value) => setState(() {
          _selectedKecamatan = value;
          print(_selectedKecamatan!.id);
          print(_selectedKecamatan!.name);
          getKelurahan(_selectedKecamatan?.id);
          //Future.microtask(() => context.requestFocus(FocusNode()));
        }),
        value: _selectedKecamatan,
        hint: Text('Pilih Provinsi ( Sesuai KTP )'),
        items: _listKecamatan.map((GetKecamatan value) {
          return new DropdownMenuItem<GetKecamatan>(
            value: value,
            child: new Text(value.name!),
          );
        }).toList(),
        borderRadius: BorderRadius.circular(5),
        isExpanded: true,
        underline: SizedBox.shrink(),
      ),
    );
  }

  Widget _buildKelurahanDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(left: 12, right: 24),
      child: _listKelurahan == null
          ? Container(
              height: 45,
              width: double.infinity,
              padding: EdgeInsets.only(top: 8),
              child: Text('Pilih Kelurahan',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
            )
          : DropdownButton<GetKelurahan>(
              style: TextStyle(fontSize: 12, color: Colors.black54),
              onChanged: (value) => setState(() {
                _selectedKelurahan = value;
              }),
              value: _selectedKelurahan,
              hint: Text('Pilih Kelurahan'),
              items: _listKelurahan.map((GetKelurahan value) {
                return new DropdownMenuItem<GetKelurahan>(
                  value: value,
                  child: new Text(value.name!),
                );
              }).toList(),
              borderRadius: BorderRadius.circular(7),
              isExpanded: true,
              underline: SizedBox.shrink(),
            ),
    );
  }
}
