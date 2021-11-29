import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/home_screen.dart';
import 'package:flutter_application_3/screen/main_menu_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  String kec = '';
  String kel = '';
  String jenisPermohonan = '';
  bool isSubmit = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  List<File> uploadFiles = <File>[];
  List<String> kecamatan = [
    'Bungus Teluk Kabung',
    'Koto Tangah',
    'Kuranji',
    '	Lubuk Begalung',
    'Pauh'
  ];
  List<String> kelurahan = [
    'kel1',
    'kel2',
    'kel3',
    'kel4',
    'kel5',
    'kel6',
    'kel7',
  ];
  List<String> jenis_permohonan = [
    'Surat Informasi',
    'Surat Rekomendasi',
  ];

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

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
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
                        showSelectedItems: true,
                        items: jenis_permohonan,
                        // label: "Pilih Jenis Permohonan",
                        hint: "Pilih Jenis Permohonan",
                        dropdownSearchBaseStyle: TextStyle(
                          fontSize: 12.0,
                        ),
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
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: kecamatan,
                        // label: "Pilih Kecamatan",
                        hint: "Pilih Kecamatan",
                        dropdownSearchBaseStyle: TextStyle(
                          fontSize: 12,
                        ),
                        onChanged: (value) {
                          setState(() {
                            kec = value!;
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
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: kelurahan,
                        //   label: "Pilih Keluarahn",
                        hint: "Pilih Kelurahan",
                        dropdownSearchBaseStyle: TextStyle(
                          fontSize: 12,
                        ),
                        onChanged: (value) {
                          setState(() {
                            kel = value!;
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
                        keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
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
                      showDialog(
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
                                      borderRadius: BorderRadius.circular(10),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(65),
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
                          });
                    });
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
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
}
