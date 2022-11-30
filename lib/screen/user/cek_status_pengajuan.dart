import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/screen/admin/preview_surat_balasan_screen_new.dart';
import 'package:flutter_application_3/screen/user/detail_card_statuspengajuan.dart';
import 'package:flutter_application_3/screen/user/edit_form_pendaftaran.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
  bool isDelete = false;
  bool deleteCont = false;
  int? idDel = 0;

  List<ApplicationLetter1>? _listPengajuan = <ApplicationLetter1>[];
  List<ApplicationLetter1>? _listPengajuanFiltered = <ApplicationLetter1>[];

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() {
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
    setState(() {
      idDel = id;
    });
    if (deleteCont == true) {
      await CallApi().deletePengajuan(id).then((value) {
        print('ceksts');
        print(value.toString());
        if (value == 'success') {
          setState(() {
            isDelete = false;
            deleteCont = false;
            initData();
          });
        } else {
          Fluttertoast.showToast(
              msg: 'Gagal Hapus Data', timeInSecForIosWeb: 2);
          setState(() {
            isDelete = false;
            deleteCont = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.mainBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/header_new.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const Positioned(
                      bottom: 30,
                      left: 90,
                      child: Text(
                        'Cek Status Pengajuan',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25,
                    top: 30,
                    left: 25,
                  ),
                  child: TextField(
                    controller: _cekStatusFilterController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'Masukkan ID Pengajuan',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          _filteredCekStatus(
                            _listPengajuan,
                            _cekStatusFilterController.text,
                          );
                        },
                        child: Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                              child: Text(
                            'Cek Status',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25,
                    left: 25,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: isLoading == true
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: _listPengajuanFiltered!.length,
                            shrinkWrap: true,
                            physics: const PageScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 200,
                                margin: const EdgeInsets.only(
                                  bottom: 18,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(
                                        1,
                                        1,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: () {
                                            PersistentNavBarNavigator.pushNewScreen(
                                                context,
                                                screen:
                                                    Detail_card_statuspengajuan(
                                                        _listPengajuanFiltered![
                                                            index]),
                                                withNavBar: false);
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    DateFormat(
                                                            'dd MMM yyyy, HH:mm')
                                                        .format(
                                                            _listPengajuanFiltered![
                                                                    index]
                                                                .createdAt!),
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      textStyle: TextStyle(
                                                        color: Colors.grey[500],
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'ID :${_listPengajuanFiltered![index].id}',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      textStyle: TextStyle(
                                                        color: Colors.grey[500],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Divider(
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Nama Pengguna',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                  Text(
                                                    'Status',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Row(
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
                                                        textStyle:
                                                            const TextStyle(
                                                          color: ColorPallete
                                                              .mainColor,
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
                                                                  .grey[700],
                                                            ),
                                                          ),
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
                                                                const TextStyle(
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 12,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Surat Balasan',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    _listPengajuanFiltered![
                                                                    index]
                                                                .status!
                                                                .toLowerCase ==
                                                            'ditolak'
                                                        ? Text(
                                                            'Alasan Ditolak',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 14,
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 4,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    _listPengajuanFiltered![
                                                                    index]
                                                                .status!
                                                                .toLowerCase !=
                                                            'disetujui'
                                                        ? Text(
                                                            '-',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 14,
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        : Text(
                                                            '-',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 14,
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                    _listPengajuanFiltered![
                                                                    index]
                                                                .status!
                                                                .toLowerCase ==
                                                            'ditolak'
                                                        ? Text(
                                                            _listPengajuanFiltered![
                                                                    index]
                                                                .reasonRejection!,
                                                            // "Kurang memenuhi kualifikasi",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 12,
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                              _listPengajuanFiltered![index]
                                                          .mailRequest !=
                                                      null
                                                  ? _listPengajuanFiltered![
                                                                  index]
                                                              .mailRequest
                                                              ?.body !=
                                                          null
                                                      ? Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                PersistentNavBarNavigator.pushNewScreen(
                                                                    context,
                                                                    screen: PreviewSuratBalasanScreenNew(
                                                                        _listPengajuanFiltered![index]
                                                                            .mailRequest!
                                                                            .id!
                                                                            .toString(),
                                                                        'view',
                                                                        _listPengajuanFiltered![index]
                                                                            .id
                                                                            .toString()),
                                                                    withNavBar:
                                                                        false);
                                                              },
                                                              child: Text(
                                                                'Lihat Surat Balasan',
                                                                style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        12,
                                                                    textStyle: const TextStyle(
                                                                        color: Colors
                                                                            .blueAccent,
                                                                        decoration:
                                                                            TextDecoration.underline)),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : const Text('-')
                                                  : Container(),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: ColorPallete.mainColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            _listPengajuanFiltered![index]
                                                        .status!
                                                        .toLowerCase() ==
                                                    'ditolak'
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              PersistentNavBarNavigator.pushNewScreen(
                                                  context,
                                                  screen:
                                                      Detail_card_statuspengajuan(
                                                          _listPengajuanFiltered![
                                                              index]),
                                                  withNavBar: false);
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.visibility_outlined,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  'Detail',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const VerticalDivider(
                                            thickness: 1,
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.white,
                                          ),
                                          _listPengajuanFiltered![index]
                                                      .status!
                                                      .toLowerCase() ==
                                                  'ditolak'
                                              ? InkWell(
                                                  onTap: () {
                                                    PersistentNavBarNavigator
                                                        .pushNewScreen(context,
                                                            screen: EditForm(
                                                                _listPengajuanFiltered![
                                                                    index]),
                                                            withNavBar: false);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(
                                                        'Edit',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          textStyle:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          _listPengajuanFiltered![index]
                                                      .status!
                                                      .toLowerCase() ==
                                                  'ditolak'
                                              ? const VerticalDivider(
                                                  thickness: 1,
                                                  indent: 10,
                                                  endIndent: 10,
                                                  color: Colors.white,
                                                )
                                              : Container(),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isDelete = true;
                                              });
                                              deletePengajuan(
                                                  _listPengajuanFiltered![index]
                                                      .id);
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/trash.png',
                                                  width: 15,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  'Hapus',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          isDelete == true
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Container(
                              height: 265,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/dustbin.png',
                                    height: 72,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Data akan dihapus',
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
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              deleteCont = true;
                                              deletePengajuan(idDel);
                                            });
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        customDialog());
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Lanjutkan',
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isDelete = false;
                                            });
                                          },
                                          child: SizedBox(
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget customDialog() {
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
                'assets/images/dustbin_success.png',
                height: 72,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Data berhaslil dihapus',
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
                    Navigator.of(context, rootNavigator: true).pop();
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
