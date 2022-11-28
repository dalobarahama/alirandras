import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/models/get_kecamatan.dart';
import 'package:flutter_application_3/models/get_kelurahan.dart';
import 'package:flutter_application_3/models/submit_formulir.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
  TextEditingController _peruntukanBangunanController = TextEditingController();
  Timer? timer;
  LatLng point = LatLng(-1.240112, 116.873320);

  String district = 'BALIKPAPAN KOTA';
  bool isSubmit = false;
  bool isLoading = true;
  bool isLoading1 = false;
  bool loc = false;
  bool isSubmitImage = false;
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
  GetKecamatan? _selectedKecamatan;
  List<GetKelurahan> _listKelurahan = <GetKelurahan>[];
  GetKelurahan? _selectedKelurahan;
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
  String? _selectedPermohonan;

  @override
  initState() {
    _selectedKecamatan = null;
    _selectedKelurahan = null;
    initData();
    super.initState();
  }

  initData() {
    getUserLocation();
    getKecamatan();
    if (isFinish[0] == true) {
      isLoading = false;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  getUserLocation() async {
    print('abc');
    currentLocation = await locateUser();
    setState(() {
      loc = true;
      point = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print('center $point');
  }

  Future<Position> locateUser() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await GeolocatorPlatform.instance.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location PErmisiion are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission permanenet denied');
    }
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
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

  /* pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        uploadFiles.addAll(result.paths.map((path) => File(path!)).toList());
      });
    } else {
      // User canceled the picker
    }
  }*/

  void submit_formulir() async {
    if (_selectedPermohonan!.length < 2) {
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
    if (_imageFileList!.length < 1) {
      Fluttertoast.showToast(msg: 'Silahkan masukkan Lampiran gambar');
      return;
    }
    if (_dokumenFileList!.length < 1) {
      Fluttertoast.showToast(msg: 'Silahkan masukkan Lampiran Dokumen');
      return;
    }
    if (_peruntukanBangunanController.text.length < 1) {
      Fluttertoast.showToast(
          msg: 'Silahkan Peruntukan Bangunan terlebih dahulu');
      return;
    }

    setState(() {
      isLoading1 = true;
    });

    await CallApi()
        .submit_formulir(
      _selectedPermohonan!,
      _selectedKecamatan!.name,
      _selectedKelurahan!.name,
      _luasBangunanController.text,
      _luasLahanController.text,
      _lokasiBangunanController.text,
      _peruntukanBangunanController.text,
      lat.toString(),
      lang.toString(),
      _imageFileList!,
      _dokumenFileList!,
    )
        .then((value) {
      setState(() {
        _dataFormulir = value;
        print(_dataFormulir.statusCode);
        if (_dataFormulir != null) {
          if (_dataFormulir.statusCode == 200) {
            setState(() {
              isFinish[3] = true;
              isLoading1 = false;
              print('ini2' + isFinish[2].toString());
            });
          } else if (_dataFormulir.statusCode! >= 400 &&
              _dataFormulir.statusCode! <= 500) {
            setState(() {
              isLoading1 = false;
              Fluttertoast.showToast(msg: 'Gagal upload data');
            });
          } else {
            setState(() {
              isLoading1 = false;
              Fluttertoast.showToast(msg: _dataFormulir.message!);
            });
          }
          //  isFinish[3] == true ? showDialog() : Container();
        } else {
          setState(() {
            isLoading1 = false;
            Fluttertoast.showToast(msg: 'Terjadi Kesalahan');
          });
        }
      });
    });
  }

  void _getPlace(double lat, double long) async {
    List<Placemark> place = await placemarkFromCoordinates(lat, long);
    print('11aa11aa');
    //print(place.first.name);
    print(place.first.locality);
    print(place.first.subLocality);

    setState(() {
      _lokasiBangunanController.text = place.first.street.toString();
      for (var i = 0; i < _listKecamatan.length; i++) {
        if (place.first.locality!
            .toLowerCase()
            .contains(_listKecamatan[i].name!.toLowerCase())) {
          setState(() {
            _selectedKecamatan = _listKecamatan[i];
            getKelurahan(_selectedKecamatan!.id);
          });
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
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
                            textStyle: const TextStyle(
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
                      ? const Center(child: CircularProgressIndicator())
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
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: const ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 100,
                                  height: 100,
                                  point: point,
                                  builder: (ctx) => Container(
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/Vector.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                          textStyle: const TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: _buildTypeDropdown(),
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
                          textStyle: const TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                        width: 215,
                        height: 50,
                        child: _listKecamatan == null
                            ? const CircularProgressIndicator()
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
                          textStyle: const TextStyle(
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
                          textStyle: const TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
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
                          textStyle: const TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
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
                    Container(
                      width: 105,
                      child: Text(
                        'Lokasi Bangunan / Lahan',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            textStyle: const TextStyle(
                              color: Colors.black54,
                            )),
                      ),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
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
                    Container(
                      width: 105,
                      child: Text(
                        'Peruntukan Bangunan',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            textStyle: const TextStyle(
                              color: Colors.black54,
                            )),
                      ),
                    ),
                    Container(
                      width: 215,
                      height: 50,
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
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
              Container(
                child: Padding(
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
                                  textStyle: const TextStyle(
                                    color: Colors.black54,
                                  )),
                            ),
                            Text(
                              '(Deetail Site Plan, Peta Kontur, Tata Kelola Air',
                              style: GoogleFonts.roboto(
                                  fontSize: 9,
                                  textStyle: const TextStyle(
                                    color: Colors.black54,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: InkWell(
                          onTap: () {
                            _imgFromGallery(0);
                          },
                          child: Container(
                            width: 60,
                            height: 60,
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
                                                    textStyle: const TextStyle(
                                                      color: Colors.grey,
                                                    )),
                                              )
                                        : Text(
                                            '+',
                                            style: GoogleFonts.roboto(
                                                fontSize: 30,
                                                textStyle: const TextStyle(
                                                  color: Colors.grey,
                                                )),
                                          )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _imgFromGallery(1);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
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
                                                  textStyle: const TextStyle(
                                                    color: Colors.grey,
                                                  )),
                                            )
                                      : Text(
                                          '+',
                                          style: GoogleFonts.roboto(
                                              fontSize: 30,
                                              textStyle: const TextStyle(
                                                color: Colors.grey,
                                              )),
                                        )),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _imgFromGallery(2);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
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
                                                  textStyle: const TextStyle(
                                                    color: Colors.grey,
                                                  )),
                                            )
                                      : Text(
                                          '+',
                                          style: GoogleFonts.roboto(
                                              fontSize: 30,
                                              textStyle: const TextStyle(
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
                          textStyle: const TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lampiran Dokumen',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            textStyle: const TextStyle(
                              color: Colors.black54,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: InkWell(
                          onTap: () {
                            _dokumenFromFiles(0);
                          },
                          child: Container(
                            width: 60,
                            height: 60,
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
                                            ? const Image(
                                                image: AssetImage(
                                                    'assets/images/pdf_icon.png'))
                                            : Text(
                                                '+',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 30,
                                                    textStyle: const TextStyle(
                                                      color: Colors.grey,
                                                    )),
                                              )
                                        : Text(
                                            '+',
                                            style: GoogleFonts.roboto(
                                                fontSize: 30,
                                                textStyle: const TextStyle(
                                                  color: Colors.grey,
                                                )),
                                          )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _dokumenFromFiles(1);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
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
                                          ? const Image(
                                              image: AssetImage(
                                                  'assets/images/pdf_icon.png'))
                                          : Text(
                                              '+',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 30,
                                                  textStyle: const TextStyle(
                                                    color: Colors.grey,
                                                  )),
                                            )
                                      : Text(
                                          '+',
                                          style: GoogleFonts.roboto(
                                              fontSize: 30,
                                              textStyle: const TextStyle(
                                                color: Colors.grey,
                                              )),
                                        )),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _dokumenFromFiles(2);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
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
                                          ? const Image(
                                              image: AssetImage(
                                                  'assets/images/pdf_icon.png'))
                                          : Text(
                                              '+',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 30,
                                                  textStyle: const TextStyle(
                                                    color: Colors.grey,
                                                  )),
                                            )
                                      : Text(
                                          '+',
                                          style: GoogleFonts.roboto(
                                              fontSize: 30,
                                              textStyle: const TextStyle(
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
                          textStyle: const TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: InkWell(
                  onTap: () {
                    submit_formulir();
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: isLoading1 == true
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Submit',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    textStyle: const TextStyle(
                                      color: Colors.white70,
                                    )),
                              )),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        isFinish[3] == true
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 40),
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'Submit Berhasil!',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 40, left: 40),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              child: Center(
                                                child: Text(
                                                  'Kembali',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12,
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              )),
                                        ),
                                      )
                                    ],
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
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(Icons.check,
                                  size: 50, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            : Container()
      ]),
    );
  }

  Widget _buildKecamatanDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.only(left: 12, right: 24),
      child: DropdownButton<GetKecamatan>(
        style: const TextStyle(fontSize: 12, color: Colors.black54),
        onChanged: (value) => setState(() {
          _selectedKecamatan = value;
          print(_selectedKecamatan!.id);
          print(_selectedKecamatan!.name);
          getKelurahan(_selectedKecamatan?.id);
          //Future.microtask(() => context.requestFocus(FocusNode()));
        }),
        value: _selectedKecamatan,
        hint: const Text('Pilih Kecamatan'),
        items: _listKecamatan.map((GetKecamatan value) {
          return DropdownMenuItem<GetKecamatan>(
            value: value,
            child: Text(value.name!),
          );
        }).toList(),
        borderRadius: BorderRadius.circular(5),
        isExpanded: true,
        underline: const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildKelurahanDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.only(left: 12, right: 24),
      child: _listKelurahan == null
          ? Container(
              height: 45,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              child: const Text('Pilih Kelurahan',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
            )
          : DropdownButton<GetKelurahan>(
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              onChanged: (value) => setState(() {
                _selectedKelurahan = value;
              }),
              value: _selectedKelurahan,
              hint: const Text('Pilih Kelurahan'),
              items: _listKelurahan.map((GetKelurahan value) {
                return DropdownMenuItem<GetKelurahan>(
                  value: value,
                  child: Text(value.name!),
                );
              }).toList(),
              borderRadius: BorderRadius.circular(7),
              isExpanded: true,
              underline: const SizedBox.shrink(),
            ),
    );
  }

  Widget _buildTypeDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.only(left: 12, right: 24),
      child: jenis_permohonan == null
          ? Container(
              height: 45,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              child: const Text('Pilih Jenis Permohonan',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
            )
          : DropdownButton<String>(
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              value: _selectedPermohonan,
              hint: const Text('Pilih Jenis Permohonan'),
              onChanged: (newValue) => setState(() {
                _selectedPermohonan = newValue;
              }),
              items: jenis_permohonan.map((String value1) {
                return DropdownMenuItem<String>(
                  value: value1,
                  child: Text(value1),
                );
              }).toList(),
              borderRadius: BorderRadius.circular(7),
              isExpanded: true,
              underline: const SizedBox.shrink(),
            ),
    );
  }
}
