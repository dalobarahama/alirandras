import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
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

import '../../helper/const.dart';
import '../../utils/color_pallete.dart';

class EditForm extends StatefulWidget {
  ApplicationLetter1 _dataForm = ApplicationLetter1();
  EditForm(this._dataForm);

  @override
  _EditFormState createState() => _EditFormState(this._dataForm);
}

class _EditFormState extends State<EditForm> {
  ApplicationLetter1 _dataForm = ApplicationLetter1();
  _EditFormState(this._dataForm);

  final TextEditingController _luasBangunanController = TextEditingController();
  final TextEditingController _luasLahanController = TextEditingController();
  final TextEditingController _lokasiBangunanController =
      TextEditingController();
  final TextEditingController _peruntukanBangunanController =
      TextEditingController();
  final TextEditingController _nomorYangDapatDihubungi =
      TextEditingController();
  String link = 'http://alirandras.inotive.id';
  LatLng point = LatLng(-1.240112, 116.873320);
  String jenisPermohonan = '';
  String district = 'BALIKPAPAN KOTA';
  bool isSubmit = false;
  bool isLoading = true;
  bool isLoading1 = false;
  bool loc = false;
  int countAttachments = 0;
  int countDoc = 0;
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

  final List<XFile> _imageFileList = <XFile>[];

  final List<File> _dokumenFileList = <File>[];

  final List<String> _dokumenFileListFromUrl = <String>[];

  final List<File> _layoutFileList = <File>[];
  final List<File> _konturRencanaFileList = <File>[];
  final List<File> _layoutSistemRencanaDrainaseFileList = <File>[];
  final List<File> _detailBendaliDrainaseFileList = <File>[];
  final List<File> _filePendukungList = <File>[];

  final List<RegistrationFormAttachment> _layoutFileListFromUrl =
      <RegistrationFormAttachment>[];
  final List<RegistrationFormAttachment> _konturRencanaFileListFromUrl =
      <RegistrationFormAttachment>[];
  final List<RegistrationFormAttachment>
      _layoutSistemRencanaDrainaseFileListFromUrl =
      <RegistrationFormAttachment>[];
  final List<RegistrationFormAttachment> _detailBendaliDrainaseFileListFromUrl =
      <RegistrationFormAttachment>[];
  final List<RegistrationFormDocument> _filePendukungListFromUrl =
      <RegistrationFormDocument>[];

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

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() {
    _selectedKecamatan = null;
    _selectedKelurahan = null;

    countAttachments = _dataForm.registrationFormAttachments!.length;
    countDoc = _dataForm.registrationFormDocuments!.length;

    getKecamatan();

    setState(() {
      if (_dataForm.registrationFormAttachments != null) {
        for (var item in _dataForm.registrationFormAttachments!) {
          if (item.category == CategoryFile.fileLayout) {
            _layoutFileListFromUrl.add(item);
          } else if (item.category == CategoryFile.konturRencana) {
            _konturRencanaFileListFromUrl.add(item);
          } else if (item.category ==
              CategoryFile.layoutSistemRencanaDrainase) {
            _layoutSistemRencanaDrainaseFileListFromUrl.add(item);
          } else if (item.category == CategoryFile.detailBendaliDrainase) {
            _detailBendaliDrainaseFileListFromUrl.add(item);
          }
          countAttachments += 1;
        }
      }

      if (_dataForm.registrationFormDocuments != null) {
        for (var item in _dataForm.registrationFormDocuments!) {
          countDoc += 1;
          _filePendukungListFromUrl.add(item);
        }
      }

      _luasBangunanController.text = _dataForm.buildingArea!;
      _luasLahanController.text = _dataForm.landArea!;
      _lokasiBangunanController.text = _dataForm.buildingLocation!;
      _nomorYangDapatDihubungi.text = _dataForm.noPhone!;
      jenisPermohonan = _dataForm.type!;
      lat = _dataForm.lat!;
      lang = _dataForm.lng!;
      point = LatLng(lat, lang);
      loc = true;
    });
  }

  _dokumenFromFiles(String fileType) async {
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
    if (fileType == CategoryFile.fileLayout) {
      setState(() {
        _layoutFileList.add(file);
      });
    } else if (fileType == CategoryFile.konturRencana) {
      setState(() {
        _konturRencanaFileList.add(file);
      });
    } else if (fileType == CategoryFile.layoutSistemRencanaDrainase) {
      setState(() {
        _layoutSistemRencanaDrainaseFileList.add(file);
      });
    } else if (fileType == CategoryFile.detailBendaliDrainase) {
      setState(() {
        _detailBendaliDrainaseFileList.add(file);
      });
    } else {
      setState(() {
        _filePendukungList.add(file);
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

    setState(() {
      _lokasiBangunanController.text = place.first.street.toString();
    });
  }

  void deleteImage(int id, int index) async {
    await CallApi().deleteImage(id).then((value) {
      setState(() {
        _dataForm.registrationFormAttachments!.removeAt(index);
        countAttachments -= 1;
        initData();
      });
    });
  }

  void deleteFileAttachment(int id, RegistrationFormAttachment item) async {
    String category = item.category!;
    await CallApi().deleteFileLayout(id).then((value) {
      if (value == true) {
        if (category == CategoryFile.fileLayout) {
          setState(() {
            _layoutFileListFromUrl.remove(item);
          });
        } else if (category == CategoryFile.konturRencana) {
          setState(() {
            _konturRencanaFileListFromUrl.remove(item);
          });
        } else if (category == CategoryFile.layoutSistemRencanaDrainase) {
          setState(() {
            _layoutSistemRencanaDrainaseFileListFromUrl.remove(item);
          });
        } else if (category == CategoryFile.detailBendaliDrainase) {
          setState(() {
            _detailBendaliDrainaseFileListFromUrl.remove(item);
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Error");
      }
    });
  }

  void deleteDoccument(int id, RegistrationFormDocument item) async {
    await CallApi().deleteDocument(id).then((value) {
      setState(() {
        _filePendukungListFromUrl.remove(item);
      });
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
    if (_selectedKelurahan == null) {
      Fluttertoast.showToast(msg: 'Silahkan pilih kelurahan terlebih dahulu.');
      return;
    }
    if (_luasBangunanController.text.isEmpty) {
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
    if (_nomorYangDapatDihubungi.text.length < 6) {
      Fluttertoast.showToast(msg: 'Nomor yang Dapat Dihubungi belum lengkap');
      return;
    }
    if (_nomorYangDapatDihubungi.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Silahkan masukkan Nomor yang Dapat Dihubungi');
      return;
    }

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
            _peruntukanBangunanController.text,
            lat.toString(),
            lang.toString(),
            _nomorYangDapatDihubungi.text,
            _dataForm.id,
            _layoutFileList,
            _konturRencanaFileList,
            _layoutSistemRencanaDrainaseFileList,
            _detailBendaliDrainaseFileList,
            _filePendukungList)
        .then((value) {
      setState(() {
        _dataFormulir = value;

        if (_dataFormulir.statusCode == 200) {
          setState(() {
            isFinish[3] = true;
            isLoading1 = false;
            Fluttertoast.showToast(msg: 'Data berhasil di submit');
            Timer(const Duration(seconds: 3), () {
              Navigator.pop(context);
            });
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
                      const SizedBox(height: 70),
                      Container(
                        height: 50,
                        child: const Center(
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
                                      const MainMenuScreen())); //ini nanti ubah yang pakai index supaya ga ilang nav bar
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: const Center(
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
                      child: const Icon(Icons.check,
                          size: 30, color: Colors.white),
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
      appBar: AppBar(
        backgroundColor: ColorPallete.mainBackgroundColor,
        title: const Text(
          "Edit Pengajuan",
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
      body: SingleChildScrollView(
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
                child: _buildJenisPermohonanDropdown(),
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
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextField(
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
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
                                    image:
                                        AssetImage('assets/images/Vector.png'),
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
                      'Layout, Kontur Rencana, Tata Kelola Air, Layout Sistem Drainase, Detail Bendali & Drainase, File Pendukung Lainnya',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              uploadFile('Upload File Layout', _layoutFileListFromUrl,
                  _layoutFileList, CategoryFile.fileLayout),
              const SizedBox(
                height: 40,
              ),
              uploadFile(
                  'Upload File Kontur Rencana',
                  _konturRencanaFileListFromUrl,
                  _konturRencanaFileList,
                  CategoryFile.konturRencana),
              const SizedBox(
                height: 40,
              ),
              uploadFile(
                  'Upload File Layout Sistem Drainase',
                  _layoutSistemRencanaDrainaseFileListFromUrl,
                  _layoutSistemRencanaDrainaseFileList,
                  CategoryFile.layoutSistemRencanaDrainase),
              const SizedBox(
                height: 40,
              ),
              uploadFile(
                  'Upload File Detail Bendali & Drainase',
                  _detailBendaliDrainaseFileListFromUrl,
                  _detailBendaliDrainaseFileList,
                  CategoryFile.detailBendaliDrainase),
              const SizedBox(
                height: 40,
              ),
              uploadFileDocument(
                  'Upload File File Pendukung Lainnya',
                  _filePendukungListFromUrl,
                  _filePendukungList,
                  CategoryFile.filePendukung),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    update_formulir();
                  });
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJenisPermohonanDropdown() {
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
              value: jenisPermohonan,
              hint: Text(
                'Pilih Permohonan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              onChanged: (newValue) => setState(() {
                jenisPermohonan = newValue!;
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

  Widget _buildKecamatanDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
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
          getKelurahan(_selectedKecamatan?.id);
        }),
        value: _selectedKecamatan,
        hint: const Text('Pilih Kecamatan'),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: DropdownButton<GetKelurahan>(
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
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

  Widget uploadFile(
      String title,
      List<RegistrationFormAttachment> listStringUrl,
      List<File> listFile,
      String fileType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 14,
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () {
            _dokumenFromFiles(fileType);
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
            ...listStringUrl.map((file) {
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
                          child: file.file!.split('.').last != 'pdf'
                              ? Image.network(
                                  'https://alirandras.inotive.id${file.file}')
                              : Image.asset('assets/images/pdf_icon.png'),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            file.file!.split('/').last,
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
                        deleteFileAttachment(file.id!, file);
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
            ...listFile.map((file) {
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
                              : Image.asset('assets/images/pdf_icon.png'),
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
                          listFile.remove(file);
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
      ],
    );
  }

  Widget uploadFileDocument(
      String title,
      List<RegistrationFormDocument> listStringUrl,
      List<File> listFile,
      String fileType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 14,
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () {
            _dokumenFromFiles(fileType);
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
            ...listStringUrl.map((file) {
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
                          child: file.document!.split('.').last != 'pdf'
                              ? Image.network(
                                  'https://alirandras.inotive.id${file.document}')
                              : Image.asset('assets/images/pdf_icon.png'),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            file.document!.split('/').last,
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
                        deleteDoccument(file.id!, file);
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
            ...listFile.map((file) {
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
                              : Image.asset('assets/images/pdf_icon.png'),
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
                          listFile.remove(file);
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
      ],
    );
  }
}
