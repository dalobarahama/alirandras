import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/models/get_kecamatan.dart';
import 'package:flutter_application_3/models/get_kelurahan.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/models/submit_formulir.dart';
import 'package:flutter_application_3/screen/user/main_menu_screen.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class EditForm extends StatefulWidget {
  RegistrationForm1 _dataForm = RegistrationForm1();
  EditForm(this._dataForm);

  @override
  _EditFormState createState() => _EditFormState(this._dataForm);
}

class _EditFormState extends State<EditForm> {
  RegistrationForm1 _dataForm = RegistrationForm1();
  _EditFormState(this._dataForm);

  TextEditingController _luasBangunanController = TextEditingController();
  TextEditingController _luasLahanController = TextEditingController();
  TextEditingController _lokasiBangunanController = TextEditingController();
  TextEditingController _alamatLengkapController = TextEditingController();
  LatLng point = LatLng(-1.240112, 116.873320);
  String jenisPermohonan = '';
  String district = 'BALIKPAPAN KOTA';
  bool isSubmit = false;
  bool isLoading = true;
  bool isLoading1 = false;
  bool loc = false;
  Position currentLocation = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime(0),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  double lat = 0;
  double lang = 0;
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
  void initState() {
    _selectedKecamatan = null;
    _selectedKelurahan = null;

    print(point);
    getKecamatan();
    setState(() {
      _luasBangunanController.text = _dataForm.buildingArea!;
      _luasLahanController.text = _dataForm.landArea!;
      _lokasiBangunanController.text = _dataForm.buildingLocation!;
      _alamatLengkapController.text = _dataForm.completeAddress!;
      point = LatLng(_dataForm.lat!, _dataForm.lng!);
      print(point);
      loc = true;
    });
    super.initState();
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _imageFile = image;
    });
  }

  getKecamatan() async {
    await CallApi().getKecamatan().then((value) {
      setState(() {
        isFinish[0] = true;
        _listKecamatan = value;
        print(_listKecamatan[0].name);
        for (var i = 0; i < _listKecamatan.length; i++) {
          print(_listKecamatan[i].name);
          print(_dataForm.district);
          if (_listKecamatan[i].name == _dataForm.district) {
            setState(() {
              _selectedKecamatan = _listKecamatan[i];
              getKelurahan(_selectedKecamatan!.id);
            });
          }
        }
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
        for (var y = 0; y < _listKelurahan.length; y++) {
          if (_listKelurahan[y].name == _dataForm.subdistrict) {
            setState(() {
              _selectedKelurahan = _listKelurahan[y];
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 15),
                child: Row(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                    padding: const EdgeInsets.only(left: 27, top: 20),
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
                  child: loc == false
                      ? Center(child: CircularProgressIndicator())
                      : FlutterMap(
                          options: MapOptions(
                              center: point,
                              zoom: 18.0,
                              onTap: (p, y) {
                                setState(() {
                                  point = y;
                                  print(point);
                                  lat = y.latitude;
                                  lang = y.longitude;
                                  // _getPlace(lat, lang);
                                });
                              }),
                          layers: [
                            TileLayerOptions(
                              urlTemplate:
                                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayerOptions(markers: [
                              Marker(
                                  width: 100,
                                  height: 100,
                                  point: point,
                                  builder: (ctx) => Container(
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/Vector.png'),
                                        ),
                                      ))
                            ])
                          ],
                        ),
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
                        selectedItem: _dataForm.type,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: InkWell(
                          onTap: () {
                            _imgFromGallery();
                          },
                          child: DottedBorder(
                            color: Colors.grey,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                  child: Text(
                                '+',
                                style: GoogleFonts.roboto(
                                    fontSize: 30,
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                    )),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      child: InkWell(
                        onTap: () {
                          _imgFromGallery();
                        },
                        child: DottedBorder(
                          color: Colors.grey,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                                child: Text(
                              '+',
                              style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                  )),
                            )),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      child: InkWell(
                        onTap: () {
                          _imgFromGallery();
                        },
                        child: DottedBorder(
                          color: Colors.grey,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                                child: Text(
                              '+',
                              style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                  )),
                            )),
                          ),
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
                  /*onTap: () {
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
                  },*/
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
                height: 20,
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
        hint: Text('Pilih Kecamatan'),
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
