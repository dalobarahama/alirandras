import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/screen/log_in.dart';
import 'package:flutter_application_3/screen/user/detail_card_statuspengajuan.dart';
import 'package:flutter_application_3/screen/user/edit_form_pendaftaran.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class Cek_status_pengajuan extends StatefulWidget {
  const Cek_status_pengajuan({Key? key}) : super(key: key);

  @override
  _Cek_status_pengajuanState createState() => _Cek_status_pengajuanState();
}

class _Cek_status_pengajuanState extends State<Cek_status_pengajuan> {
  TextEditingController _cekStatusFilterController = TextEditingController();
  bool isLoading = true;

  List<ApplicationLetter1>? _listPengajuan = <ApplicationLetter1>[];
  List<ApplicationLetter1>? _listPengajuanFiltered = <ApplicationLetter1>[];

  @override
  void initState() {
    CallApi().getListPengajuan().then((value) {
      setState(() {
        print('asu');
        isLoading = false;
        _listPengajuan = value;
        _listPengajuanFiltered = value;

        // if (_listPengajuan == null) {
        //   Fluttertoast.showToast(
        //       msg: 'Terjadi Kesalahan', timeInSecForIosWeb: 2);
        //   Navigator.pop(context);
        // } else if (_listPengajuan![0].status == 401) {
        //   Fluttertoast.showToast(
        //       msg: 'Terjadi Kesalahan', timeInSecForIosWeb: 2);
        //   Navigator.pop(context);
        // }
      });
    });
    super.initState();
  }

  List<ApplicationLetter1>? _filteredCekStatus(
      List<ApplicationLetter1>? _listPengajuan,
      String _cekStatusFilteredController) {
    setState(() {
      print('asd');
      _listPengajuanFiltered = _listPengajuan!
          .where((u) => (u.id
              .toString()
              .toLowerCase()
              .contains(_cekStatusFilteredController.toLowerCase())))
          .toList();
    });

    return _listPengajuanFiltered;
  }

  void _launchURL(String? url) async {
    if (!await launch(url!)) throw 'Could not launch $url';
  }

  void deletePengajuan(int? id) async {
    await CallApi().deletePengajuan(id).then((value) {
      print('ceksts');
      print(value.toString());
      if (value == 'success') {
        Fluttertoast.showToast(
            msg: 'Berhasil Hapus Data', timeInSecForIosWeb: 2);
        setState(() {
          initState();
        });
      } else {
        Fluttertoast.showToast(msg: 'Gagal Hapus Data', timeInSecForIosWeb: 2);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 27,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 95),
                    child: Container(
                      child: Text(
                        'Cek Status Pengajuan',
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35, top: 20, left: 10),
                child: TextField(
                  controller: _cekStatusFilterController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: ' Masukkan ID Pengajuan',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    suffixIcon: InkWell(
                      onTap: () {
                        _filteredCekStatus(
                            _listPengajuan, _cekStatusFilterController.text);
                      },
                      child: Container(
                        width: 120,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          'Cek Status',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: isLoading == true
                      ? Center(child: CircularProgressIndicator())
                      : Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListView.builder(
                                itemCount: _listPengajuanFiltered!.length,
                                shrinkWrap: true,
                                physics: PageScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.all(10),
                                    color: Colors.grey[200],
                                    shadowColor: Colors.black,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(17.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'ID :' +
                                                      _listPengajuanFiltered![
                                                              index]
                                                          .id
                                                          .toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      textStyle: TextStyle(
                                                        color: Colors.grey[500],
                                                      )),
                                                ),
                                                Text(
                                                  DateFormat(
                                                          'dd MMMM yy, HH:mm')
                                                      .format(
                                                          _listPengajuanFiltered![
                                                                  index]
                                                              .createdAt!),
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      textStyle: TextStyle(
                                                        color: Colors.grey[500],
                                                      )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 1,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 10, top: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Nama Pengguna',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        textStyle: TextStyle(
                                                          color:
                                                              Colors.grey[500],
                                                        )),
                                                  ),
                                                  Text(
                                                    'Status',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        textStyle: TextStyle(
                                                          color:
                                                              Colors.grey[500],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 10, top: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    _listPengajuanFiltered![
                                                            index]
                                                        .user!
                                                        .name!,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        textStyle: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                        )),
                                                  ),
                                                  _listPengajuanFiltered![index]
                                                              .status!
                                                              .toLowerCase !=
                                                          'disetujui'
                                                      ? Text(
                                                          _listPengajuanFiltered![
                                                                  index]
                                                              .status!
                                                              .toUpperCase(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                  )),
                                                        )
                                                      : Text(
                                                          _listPengajuanFiltered![
                                                                  index]
                                                              .status!
                                                              .toUpperCase(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                  )),
                                                        ),
                                                ],
                                              ),
                                            ),
                                            _listPengajuanFiltered![index]
                                                        .status!
                                                        .toLowerCase ==
                                                    'ditolak'
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            right: 10,
                                                            top: 20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Alasan Ditolak',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        500],
                                                                  )),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 10, top: 40),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Lampiran',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        textStyle: TextStyle(
                                                          color:
                                                              Colors.grey[500],
                                                        )),
                                                  ),
                                                  _listPengajuanFiltered![index]
                                                              .status!
                                                              .toLowerCase ==
                                                          'ditolak'
                                                      ? Text(
                                                          _listPengajuanFiltered![
                                                                  index]
                                                              .reasonRejection!,
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                  )),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 10, top: 8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            _listPengajuanFiltered![
                                                                    index]
                                                                .registrationFormAttachments!
                                                                .length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index1) {
                                                          return Container(
                                                            child: InkWell(
                                                                onTap: () {
                                                                  String _link = 'http://alirandras.inotive.id' +
                                                                      _listPengajuanFiltered![
                                                                              index]
                                                                          .registrationFormAttachments![
                                                                              index1]
                                                                          .file
                                                                          .toString();
                                                                  _launchURL(
                                                                      _link);
                                                                },
                                                                child: Text(
                                                                  'Lampiran ' +
                                                                      (index1 +
                                                                              1)
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline),
                                                                )),
                                                          );
                                                        }),
                                                  )
                                                  /*Text(
                                      'Gambar bangunan.png',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          textStyle: TextStyle(
                                            color: Colors.grey[700],
                                          )),
                                    ),*/
                                                  ,
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 16,
                                                  ),
                                                  Icon(
                                                    Icons.visibility,
                                                    color: Colors.green,
                                                    size: 12,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          SlideToLeftRoute(
                                                              page: Detail_card_statuspengajuan(
                                                                  _listPengajuanFiltered![
                                                                      index])));
                                                    },
                                                    child: Text(
                                                      'Detail',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 12,
                                                          textStyle: TextStyle(
                                                            color: Colors.green,
                                                          )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  _listPengajuanFiltered![index]
                                                                  .status!
                                                                  .toLowerCase() ==
                                                              'ditolak' ||
                                                          _listPengajuanFiltered![
                                                                      index]
                                                                  .mailRequest ==
                                                              null
                                                      ? Container(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.edit,
                                                                color:
                                                                    Colors.red,
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      SlideToLeftRoute(
                                                                          page:
                                                                              EditForm(_listPengajuanFiltered![index])));
                                                                },
                                                                child: Text(
                                                                  'Edit',
                                                                  style: GoogleFonts
                                                                      .roboto(
                                                                          fontSize:
                                                                              12,
                                                                          textStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 12,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      deletePengajuan(
                                                          _listPengajuanFiltered![
                                                                  index]
                                                              .id);
                                                    },
                                                    child: Text(
                                                      'Hapus',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 12,
                                                          textStyle: TextStyle(
                                                            color: Colors.red,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
