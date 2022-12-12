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

import '../../utils/color_pallete.dart';
import '../../utils/transition_animation.dart';
import 'main_menu_screen.dart';

class Form_pendaftaran extends StatefulWidget {
  const Form_pendaftaran({Key? key}) : super(key: key);

  @override
  _Form_pendaftaranState createState() => _Form_pendaftaranState();
}

class _Form_pendaftaranState extends State<Form_pendaftaran> {
  final TextEditingController _luasBangunanController = TextEditingController();
  final TextEditingController _luasLahanController = TextEditingController();
  final TextEditingController _lokasiBangunanController =
      TextEditingController();
  final TextEditingController _peruntukanBangunanController =
      TextEditingController();
  final TextEditingController _nomorYangDapatDihubungi =
      TextEditingController();
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

  _dokumenFromFiles() async {
    print(_dokumenFileList!.length);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'jpg',
        'jpeg',
        'png',
      ],
    );
    File? file = File(result!.files.single.path.toString());
    String basename = file.path.split('/').last;
    print("file name: $basename");
    setState(() {
      _dokumenFileList!.add(file);
    });
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
    if (_selectedKelurahan == null) {
      Fluttertoast.showToast(msg: 'Silahkan pilih kelurahan terlebih dahulu.');
      return;
    }
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
    if (_dokumenFileList!.length < 1) {
      Fluttertoast.showToast(msg: 'Silahkan masukkan Lampiran File');
      return;
    }
    if (_nomorYangDapatDihubungi.text.length < 6) {
      Fluttertoast.showToast(
          msg: 'Silahkan masukkan Nomor yang Dapat Dihubungi');
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
      _nomorYangDapatDihubungi.text,
      _dokumenFileList!,
    )
        .then((value) {
      setState(() {
        _dataFormulir = value;
        print(_dataFormulir.statusCode);
        print("form_pendaftaran_respon: ${_dataFormulir.statusCode}");
        if (_dataFormulir != null) {
          if (_dataFormulir.statusCode == 200) {
            setState(() {
              isFinish[3] = true;
              isLoading1 = false;
              print('ini2' + isFinish[2].toString());

              showDialog(
                  context: context,
                  builder: (BuildContext context) => customDialog(context));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.mainBackgroundColor,
        title: const Text(
          "Form Pengajuan",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: ColorPallete.mainBackgroundColor,
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 35,
              left: 28,
              right: 28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jenis Permohonan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _buildTypeDropdown(),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Nomor yang Dapat Dihubungi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    controller: _nomorYangDapatDihubungi,
                    decoration: InputDecoration(
                      hintText: 'Nomor yang Dapat Dihubungi',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Kecamatan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _buildKecamatanDropdown(),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Kelurahan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _buildKelurahanDropdown(),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Luas Bangunan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            controller: _luasBangunanController,
                            decoration: InputDecoration(
                              hintText: 'Luas Bangunan',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Luas Lahan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            controller: _luasLahanController,
                            decoration: InputDecoration(
                              hintText: 'Luas Lahan',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Lokasi Bangunan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    controller: _lokasiBangunanController,
                    decoration: InputDecoration(
                      hintText: 'Lokasi Bangunan',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Map',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
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
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Upload File',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 14,
                    bottom: 14,
                    left: 17,
                    right: 17,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'File yang diperlukan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Site Plan, Peta Kontur, Tata Kelola Air',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    _dokumenFromFiles();
                    print("file length: ${_dokumenFileList!.length}");
                  },
                  child: DottedBorder(
                    color: ColorPallete.mainColor,
                    borderType: BorderType.RRect,
                    strokeWidth: 1,
                    radius: const Radius.circular(6),
                    dashPattern: const [
                      10,
                      3,
                    ],
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: ColorPallete.mainColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.upload,
                              color: ColorPallete.mainColor,
                              size: 15,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Browse',
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorPallete.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    ..._dokumenFileList!.map((file) {
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 12,
                        ),
                        padding: const EdgeInsets.only(
                          top: 14,
                          bottom: 14,
                          left: 17,
                          right: 17,
                        ),
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: file.path.split('.').last != 'pdf'
                                      ? Image.file(File(file.path))
                                      : Image.asset(
                                          'assets/images/pdf_icon.png'),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    file.path.split('/').last,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _dokumenFileList!.remove(file);
                                });
                              },
                              child: const Icon(
                                Icons.cancel_sharp,
                                color: Colors.grey,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    submit_formulir();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorPallete.mainColor,
                        borderRadius: BorderRadius.circular(6)),
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildKecamatanDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: DropdownButton<GetKecamatan>(
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        onChanged: (value) => setState(() {
          _selectedKecamatan = value;
          print(_selectedKecamatan!.id);
          print(_selectedKecamatan!.name);
          getKelurahan(_selectedKecamatan?.id);
          //Future.microtask(() => context.requestFocus(FocusNode()));
        }),
        value: _selectedKecamatan,
        hint: Text(
          'Pilih Kecamatan',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
          ),
        ),
        items: _listKecamatan.map((GetKecamatan value) {
          return DropdownMenuItem<GetKecamatan>(
            value: value,
            child: Text(value.name!),
          );
        }).toList(),
        borderRadius: BorderRadius.circular(6),
        isExpanded: true,
        underline: const SizedBox.shrink(),
        icon: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  Widget _buildKelurahanDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: _listKelurahan == null
          ? Container(
              height: 45,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Pilih Permohonan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
            )
          : DropdownButton<GetKelurahan>(
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: (value) => setState(() {
                _selectedKelurahan = value;
              }),
              value: _selectedKelurahan,
              hint: Text(
                'Pilih Kelurahan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              items: _listKelurahan.map((GetKelurahan value) {
                return DropdownMenuItem<GetKelurahan>(
                  value: value,
                  child: Text(value.name!),
                );
              }).toList(),
              borderRadius: BorderRadius.circular(6),
              isExpanded: true,
              underline: const SizedBox.shrink(),
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
    );
  }

  Widget _buildTypeDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: jenis_permohonan == null
          ? Container(
              height: 45,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Pilih Permohonan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
            )
          : DropdownButton<String>(
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              value: _selectedPermohonan,
              hint: Text(
                'Pilih Permohonan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              onChanged: (newValue) => setState(() {
                _selectedPermohonan = newValue;
              }),
              items: jenis_permohonan.map((String value1) {
                return DropdownMenuItem<String>(
                  value: value1,
                  child: Text(value1),
                );
              }).toList(),
              borderRadius: BorderRadius.circular(6),
              isExpanded: true,
              underline: const SizedBox.shrink(),
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
    );
  }

  Widget customDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        height: 230,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/submit_berhasil.png',
                height: 72,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Submit Berhasil',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(context);
                    Navigator.pushReplacement(context,
                        SlideToLeftRoute(page: const MainMenuScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorPallete.mainColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        'Ok',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
