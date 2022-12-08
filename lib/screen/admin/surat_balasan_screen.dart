import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/admin/approval_screen.dart';
import 'package:flutter_application_3/screen/admin/detail_status_pemohon.dart';
import 'package:flutter_application_3/screen/admin/preview_surat_balasan_screen_new.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';

import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/models/admin_pemohon_model.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../models/admin_home_model.dart';
import '../../utils/color_pallete.dart';
import 'detail_status_pengajuan_screen_admin.dart';

class SuratBalasanScreen extends StatefulWidget {
  const SuratBalasanScreen({Key? key}) : super(key: key);

  @override
  _SuratBalasanScreenState createState() => _SuratBalasanScreenState();
}

class _SuratBalasanScreenState extends State<SuratBalasanScreen> {
  User1 _userData = User1();
  bool isLoading = true;
  // GetListPemohon _data = GetListPemohon();
  AdminHomeModel _data = AdminHomeModel();

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    CallStorage().getUserData().then((value) {
      setState(() {
        print(value.name);
        _userData = value;
        print(_userData.name);
        initData('', '');
      });
    });
    // TODO: implement initState
    super.initState();
  }

  navigateToApprovalScreen(String id) async {
    var res = await PersistentNavBarNavigator.pushNewScreen(context,
        screen: ApprovalScreen('permohonan', id), withNavBar: false);
    setState(() {
      isLoading = true;
    });
    Timer(const Duration(seconds: 1), () {
      initData('', '');
    });
  }

  initData(year, status) async {
    isLoading = true;
    // await CallAdminApi().getListPemohonData().then((value) {
    //   setState(() {
    //     _data = value;
    //     isLoading = false;
    //   });
    // });
    await CallAdminApi().getAdminHomeData(year, status).then((value) {
      setState(() {
        _data = value;
        isLoading = false;
      });
    });
  }

  Future<void> refresh() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      initData('', '');
    });
  }

  List<String> statusData = [
    'semua',
    'diterima',
    'ditolak',
    'diproses',
    'selesai direvisi'
  ];
  String selectedStatus = 'semua';
  List<String> tahunData = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030'
  ];
  String? selectedTahun;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.mainBackgroundColor,
        title: const Text(
          "Surat Balasan",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: ColorPallete.mainBackgroundColor,
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () => refresh(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 42,
                      width: 135,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: DropdownButton<String>(
                        items: statusData
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                value.toUpperCase(),
                                style: GoogleFonts.roboto(fontSize: 12),
                              ),
                            ),
                          );
                        }).toList(),
                        value: selectedStatus,
                        underline: Container(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text('Choose'),
                        onChanged: (e) {
                          setState(() {
                            String? tempTahun;
                            String? temptStatus;
                            selectedStatus = e!.toLowerCase();
                            selectedTahun == null
                                ? tempTahun = ''
                                : tempTahun = selectedTahun;
                            selectedStatus == 'semua'
                                ? temptStatus = ''
                                : temptStatus = selectedStatus;
                            initData(tempTahun, temptStatus);
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 42,
                      width: 135,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: DropdownButton<String>(
                        items: tahunData
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                value.toUpperCase(),
                                style: GoogleFonts.roboto(fontSize: 12),
                              ),
                            ),
                          );
                        }).toList(),
                        value: selectedTahun,
                        underline: Container(),
                        icon: const Icon(Icons.calendar_today),
                        iconSize: 15,
                        hint: Text(
                          'Pilih Tahun',
                          style: GoogleFonts.roboto(fontSize: 12),
                        ),
                        onChanged: (e) {
                          setState(() {
                            String? tempTahun;
                            String? temptStatus;
                            selectedTahun = e!.toLowerCase();
                            selectedTahun == null
                                ? tempTahun = ''
                                : tempTahun = selectedTahun;
                            selectedStatus == 'semua'
                                ? temptStatus = ''
                                : temptStatus = selectedStatus;
                            initData(tempTahun, temptStatus);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading == true
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _data.registrationForms?.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return newCard(index);
                          // return Card(
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10)),
                          //   margin: const EdgeInsets.all(10),
                          //   color: Colors.grey[100],
                          //   shadowColor: Colors.black,
                          //   child: InkWell(
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           SlideToLeftRoute(
                          //               page: StatusPemohonScreenAdmin(_data
                          //                   .applicationLetters![index])));
                          //     },
                          //     child: Container(
                          //       padding: const EdgeInsets.all(20),
                          //       child: Column(
                          //         children: [
                          //           Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Text(
                          //                 'ID: ' +
                          //                     _data
                          //                         .applicationLetters![
                          //                             index]
                          //                         .id!
                          //                         .toString(),
                          //                 style: GoogleFonts.roboto(
                          //                     fontSize: 10,
                          //                     textStyle: TextStyle(
                          //                       color: Colors.grey[500],
                          //                     )),
                          //               ),
                          //               Text(
                          //                 DateFormat('dd MMMM yy, HH:mm')
                          //                     .format(_data
                          //                         .applicationLetters![
                          //                             index]
                          //                         .createdAt!),
                          //                 style: GoogleFonts.roboto(
                          //                     fontSize: 10,
                          //                     textStyle: TextStyle(
                          //                       color: Colors.grey[500],
                          //                     )),
                          //               ),
                          //             ],
                          //           ),
                          //           const SizedBox(
                          //             height: 20,
                          //           ),
                          //           Row(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Expanded(
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       'Nama Pemohon',
                          //                       style: GoogleFonts.roboto(
                          //                           fontSize: 12,
                          //                           textStyle: TextStyle(
                          //                             color:
                          //                                 Colors.grey[500],
                          //                           )),
                          //                     ),
                          //                     Text(
                          //                       _data
                          //                           .applicationLetters![
                          //                               index]
                          //                           .user!
                          //                           .name!,
                          //                       style: GoogleFonts.roboto(
                          //                           fontSize: 14,
                          //                           fontWeight:
                          //                               FontWeight.bold,
                          //                           textStyle:
                          //                               const TextStyle(
                          //                             color: Colors.black54,
                          //                           )),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Expanded(
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       'Status',
                          //                       style: GoogleFonts.roboto(
                          //                           fontSize: 12,
                          //                           textStyle: TextStyle(
                          //                             color:
                          //                                 Colors.grey[500],
                          //                           )),
                          //                     ),
                          //                     Text(
                          //                       _data
                          //                               .applicationLetters![
                          //                                   index]
                          //                               .status ??
                          //                           '-',
                          //                       style: GoogleFonts.roboto(
                          //                           fontSize: 14,
                          //                           fontWeight:
                          //                               FontWeight.bold,
                          //                           textStyle:
                          //                               const TextStyle(
                          //                             color: Colors.black54,
                          //                           )),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Expanded(
                          //                   child: _data
                          //                                   .applicationLetters![
                          //                                       index]
                          //                                   .status ==
                          //                               'menunggu' ||
                          //                           _data
                          //                                   .applicationLetters![
                          //                                       index]
                          //                                   .status ==
                          //                               "selesai direvisi"
                          //                       ? InkWell(
                          //                           onTap: () {
                          //                             navigateToApprovalScreen(
                          //                                 _data
                          //                                     .applicationLetters![
                          //                                         index]
                          //                                     .id!
                          //                                     .toString());
                          //                           },
                          //                           child: Container(
                          //                             padding:
                          //                                 const EdgeInsets
                          //                                         .symmetric(
                          //                                     vertical: 8,
                          //                                     horizontal:
                          //                                         10),
                          //                             decoration: BoxDecoration(
                          //                                 color: Colors.red,
                          //                                 borderRadius:
                          //                                     BorderRadius
                          //                                         .circular(
                          //                                             7)),
                          //                             child: Row(
                          //                               children: [
                          //                                 const Padding(
                          //                                   padding: EdgeInsets
                          //                                       .only(
                          //                                           left:
                          //                                               5),
                          //                                   child: Icon(
                          //                                     Icons
                          //                                         .check_circle,
                          //                                     color: Colors
                          //                                         .white,
                          //                                     size: 15,
                          //                                   ),
                          //                                 ),
                          //                                 const SizedBox(
                          //                                   width: 5,
                          //                                 ),
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                               .only(
                          //                                           left:
                          //                                               3),
                          //                                   child: Text(
                          //                                     'Verifikasi',
                          //                                     style: GoogleFonts
                          //                                         .roboto(
                          //                                             fontSize:
                          //                                                 11,
                          //                                             textStyle:
                          //                                                 const TextStyle(
                          //                                               color:
                          //                                                   Colors.white,
                          //                                             )),
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                         )
                          //                       : Container()),
                          //             ],
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget newCard(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.black,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy, HH.mm')
                          .format(_data.registrationForms![index].createdAt!),
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        textStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    Text(
                      'ID: ${_data.registrationForms?[index].id ?? 0}',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        textStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Nama Pengguna',
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            _data.registrationForms?[index].user?.name ?? '-',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(
                                color: ColorPallete.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Status',
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            _data.registrationForms?[index].mailRequest == null
                                ? '-'
                                : _data.registrationForms![index].mailRequest!
                                    .status!
                                    .toUpperCase(),
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              textStyle: TextStyle(
                                color: _data.registrationForms?[index].status ==
                                        null
                                    ? Colors.grey
                                    : _data.registrationForms![index]
                                                .mailRequest!.status !=
                                            'diterima'
                                        ? Colors.grey
                                        : Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Lampiran',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            _data.registrationForms![index].mailRequest?.body !=
                                    null
                                ? Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/pdf_icon.png',
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Dokumen Surat',
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          textStyle: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text('-')
                          ]),
                    ),
                    Expanded(
                      child: _data.registrationForms?[index].status == null
                          ? Container()
                          : _data.registrationForms![index].status != 'ditolak'
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Alasan ditolak:',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      _data.registrationForms?[index]
                                              .reasonRejection ??
                                          '-',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        textStyle: TextStyle(
                                          color: _data.registrationForms?[index]
                                                      .status ==
                                                  null
                                              ? Colors.grey
                                              : _data.registrationForms![index]
                                                          .status !=
                                                      'diterima'
                                                  ? Colors.grey
                                                  : Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _data.registrationForms?[index].status == null
                          ? Container()
                          : _data.registrationForms![index].status != 'diproses'
                              ? Container()
                              : Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: Colors.greenAccent[700],
                                          size: 15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Detail',
                                            style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              textStyle: TextStyle(
                                                color: Colors.greenAccent[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                              size: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                'Hapus',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    textStyle: const TextStyle(
                                                      color: Colors.redAccent,
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
                    _data.registrationForms?[index].mailRequest == null
                        ? Container()
                        : _data.registrationForms?[index].mailRequest!
                                    .checkMailPermission ==
                                null
                            ? Container()
                            : _data.registrationForms![index].mailRequest!
                                        .checkMailPermission!.status !=
                                    'diproses'
                                ? Container()
                                : _data.registrationForms![index].mailRequest
                                            ?.body ==
                                        null
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          // navigateToApproval(index);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Center(
                                            child: Text(
                                              'Tindak Lanjuti',
                                              style: GoogleFonts.roboto(
                                                fontSize: 11,
                                                textStyle: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: StatusPengajuanScreenAdmin(
                                _data.registrationForms![index]),
                            withNavBar: false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Detail',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (_data.registrationForms![index].mailRequest!.id !=
                              null &&
                          _data.registrationForms![index].status
                                  ?.toLowerCase() ==
                              'diterima') {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: PreviewSuratBalasanScreenNew(
                                _data.registrationForms![index].mailRequest!.id!
                                    .toString(),
                                'view',
                                _data.registrationForms![index].id.toString()),
                            withNavBar: false);
                      } else {
                        Fluttertoast.showToast(msg: "Belum ada surat balasan");
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorPallete.mainColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Lihat Surat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
