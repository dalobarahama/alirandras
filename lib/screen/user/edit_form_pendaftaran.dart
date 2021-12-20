import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/models/get_kecamatan.dart';
import 'package:flutter_application_3/models/get_kelurahan.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/models/submit_formulir.dart';
import 'package:flutter_application_3/screen/user/main_menu_screen.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class EditForm extends StatefulWidget {
  ApplicationLetter1 _dataForm = ApplicationLetter1();
  EditForm(this._dataForm);

  @override
  _EditFormState createState() => _EditFormState(this._dataForm);
}

class _EditFormState extends State<EditForm> {
  ApplicationLetter1 _dataForm = ApplicationLetter1();
  _EditFormState(this._dataForm);

  TextEditingController _luasBangunanController = TextEditingController();
  TextEditingController _luasLahanController = TextEditingController();
  TextEditingController _lokasiBangunanController = TextEditingController();
  TextEditingController _peruntukanBangunanController = TextEditingController();

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
  List<GetKecamatan> _listKecamatan = <GetKecamatan>[];
  GetKecamatan? _selectedKecamatan = GetKecamatan();
  List<GetKelurahan> _listKelurahan = <GetKelurahan>[];
  GetKelurahan? _selectedKelurahan = GetKelurahan();
  SubmitFormulir _dataFormulir = SubmitFormulir();
  List<XFile>? _imageFileList = <XFile>[];
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  List<File>? _dokumenFileList = <File>[];
  set _dokumenFile(File? value) {
    _dokumenFileList = value == null ? null : [value];
  }

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
      jenisPermohonan = _dataForm.type!;
      point = LatLng(_dataForm.lat!, _dataForm.lng!);
      print(point);
      loc = true;
    });
    super.initState();
  }

  _imgFromGallery(int index) async {
    print(_imageFileList!.length);
    if (_imageFileList!.length < 3) {
      XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        _imageFileList!.add(image!);
      });
    } else {
      XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        _imageFileList![index] = image!;
      });
    }
  }

  _dokumenFromFiles(int index) async {
    print(_dokumenFileList!.length);
    if (_dokumenFileList!.length < 3) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      File? file = File(result!.files.single.path.toString());
      setState(() {
        _dokumenFileList!.add(file);
      });
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      File? file = File(result!.files.single.path.toString());
      setState(() {
        _dokumenFileList![index] = file;
      });
    }
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

  void _getPlace(double lat, double long) async {
    List<Placemark> place = await placemarkFromCoordinates(lat, long);
    print('11aa11aa');
    print(place.first.name);

    setState(() {
      _lokasiBangunanController.text = place.first.street.toString();
    });
  }

  void update_formulir() async {
    if (jenisPermohonan.length < 2) {
      Fluttertoast.showToast(
          msg: 'Silahkan pilih jenis permohonan terlebih dahulu.');
      return;
    }
    if (_selectedKecamatan == null) {
      Fluttertoast.showToast(msg: 'Silahkan pilih kecamatan terlebih dahulu.');
      return;
    }
    // if (_selectedKelurahan == null) {
    //   Fluttertoast.showToast(msg: 'Silahkan pilih kelurahan terlebih dahulu.');
    //   return;
    // }
    if (_luasBangunanController.text.length < 1) {
      Fluttertoast.showToast(
          msg: 'Silahkan masukkan luas bangunan terlebih dahulu.');
      return;
    }
    if (_luasLahanController.text.length < 2) {
      Fluttertoast.showToast(
          msg: 'Silahkan masukkan luas lahan terlebih dahulu.');
      return;
    }
    if (_lokasiBangunanController.text.length < 2) {
      Fluttertoast.showToast(
          msg: 'Silahkan masukkan lokasi bangunan terlebih dahulu.');
      return;
    }
    /*if (_imageFileList!.length < 1) {
      Fluttertoast.showToast(msg: 'Silahkan masukkan Lampiran gambar');
      return;
    }*/

    setState(() {
      isLoading1 = true;
    });

    await CallApi()
        .update_formulir(
            jenisPermohonan,
            _selectedKecamatan!.name,
            _selectedKelurahan!.name,
            _luasBangunanController.text,
            _luasLahanController.text,
            _lokasiBangunanController.text,
            lat.toString(),
            lang.toString(),
            _imageFileList!,
            _dataForm.id,
            _dokumenFileList!)
        .then((value) {
      setState(() {
        _dataFormulir = value;
        print(_dataFormulir.statusCode);
        if (_dataFormulir != null) {
          if (_dataFormulir.statusCode == 200) {
            setState(() {
              isFinish[3] = true;
              // isLoading1 = false;
              print('ini2' + isFinish[2].toString());
            });
          } else if (_dataFormulir.statusCode! >= 400 &&
              _dataFormulir.statusCode! <= 500) {
            setState(() {
              isLoading1 = false;
              Fluttertoast.showToast(msg: _dataFormulir.message!);
            });
          } else {
            setState(() {
              isLoading1 = false;
              Fluttertoast.showToast(msg: _dataFormulir.message!);
            });
          }
          isFinish[3] == true ? _popUpDialog(context) : Container();
        } else {
          setState(() {
            isLoading1 = false;
            Fluttertoast.showToast(msg: 'Terjadi Kesalahan');
          });
        }
      });
    });
  }

  void _popUpDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                            'Update Berhasil!',
                            style: TextStyle(color: Colors.black54),
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
                            borderRadius: BorderRadius.circular(10),
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
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(Icons.check, size: 30, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          );
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
                                  _getPlace(lat, lang);
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
                        selectedItem: jenisPermohonan,
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
                      'Lokasi Bangunan/Lahan',
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
                      'Peruntukan Bangunan',
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
                        controller: _peruntukanBangunanController,
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
                    Container(
                      width: 105,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gambar Bangunan/Lahan',
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                textStyle: TextStyle(
                                  color: Colors.black54,
                                )),
                          ),
                          Text(
                            '(Deetail Site Plan, Peta Kontur, Tata Kelola Air',
                            style: GoogleFonts.roboto(
                                fontSize: 9,
                                textStyle: TextStyle(
                                  color: Colors.black54,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: InkWell(
                          onTap: () {
                            _imgFromGallery(0);
                          },
                          child: DottedBorder(
                            color: Colors.grey,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                  child: _imageFileList!.length != 0
                                      ? _imageFileList![0] != null
                                          ? Image.file(
                                              File(_imageFileList![0].path))
                                          : Text(
                                              '+',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 30,
                                                  textStyle: TextStyle(
                                                    color: Colors.grey,
                                                  )),
                                            )
                                      : Text(
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
                          _imgFromGallery(1);
                        },
                        child: DottedBorder(
                          color: Colors.grey,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                                child: _imageFileList!.length != 0 &&
                                        _imageFileList!.length > 1
                                    ? _imageFileList![1] != null
                                        ? Image.file(
                                            File(_imageFileList![1].path))
                                        : Text(
                                            '+',
                                            style: GoogleFonts.roboto(
                                                fontSize: 30,
                                                textStyle: TextStyle(
                                                  color: Colors.grey,
                                                )),
                                          )
                                    : Text(
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
                          _imgFromGallery(2);
                        },
                        child: DottedBorder(
                          color: Colors.grey,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                                child: _imageFileList!.length != 0 &&
                                        _imageFileList!.length > 2
                                    ? _imageFileList![2] != null
                                        ? Image.file(
                                            File(_imageFileList![2].path))
                                        : Text(
                                            '+',
                                            style: GoogleFonts.roboto(
                                                fontSize: 30,
                                                textStyle: TextStyle(
                                                  color: Colors.grey,
                                                )),
                                          )
                                    : Text(
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
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, top: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'dalam format jpg, jpeg, png',
                      style: GoogleFonts.roboto(
                          fontSize: 9,
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lampiran Dokumen',
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
                            _dokumenFromFiles(0);
                          },
                          child: DottedBorder(
                            color: Colors.grey,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                  child: _dokumenFileList!.length != 0
                                      ? _dokumenFileList![0] != null
                                          ? Image(
                                              image: AssetImage(
                                                  'assets/images/pdf_icon.png'))
                                          : Text(
                                              '+',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 30,
                                                  textStyle: TextStyle(
                                                    color: Colors.grey,
                                                  )),
                                            )
                                      : Text(
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
                          _dokumenFromFiles(1);
                        },
                        child: DottedBorder(
                          color: Colors.grey,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                                child: _dokumenFileList!.length != 0 &&
                                        _dokumenFileList!.length > 1
                                    ? _dokumenFileList![1] != null
                                        ? Image(
                                            image: AssetImage(
                                                'assets/images/pdf_icon.png'))
                                        : Text(
                                            '+',
                                            style: GoogleFonts.roboto(
                                                fontSize: 30,
                                                textStyle: TextStyle(
                                                  color: Colors.grey,
                                                )),
                                          )
                                    : Text(
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
                          _dokumenFromFiles(2);
                        },
                        child: DottedBorder(
                          color: Colors.grey,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                                child: _dokumenFileList!.length != 0 &&
                                        _dokumenFileList!.length > 2
                                    ? _dokumenFileList![2] != null
                                        ? Image(
                                            image: AssetImage(
                                                'assets/images/pdf_icon.png'))
                                        : Text(
                                            '+',
                                            style: GoogleFonts.roboto(
                                                fontSize: 30,
                                                textStyle: TextStyle(
                                                  color: Colors.grey,
                                                )),
                                          )
                                    : Text(
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
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, top: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'dalam format pdf',
                      style: GoogleFonts.roboto(
                          fontSize: 9,
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ),
                  ),
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
                      update_formulir();
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
                                'Update',
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
