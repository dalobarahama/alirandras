import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/helper/api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/admin_home_model.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/screen/admin/detail_status_pengajuan_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/preview_surat_balasan_screen.dart';
import 'package:flutter_application_3/screen/profile.dart';
import 'package:flutter_application_3/screen/user/detail_card_statuspengajuan.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:intl/intl.dart';

class HomeScreenAdmin extends StatefulWidget {
  Function logout;
  HomeScreenAdmin(this.logout);
  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState(this.logout);
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  Function logout;
  _HomeScreenAdminState(this.logout);
  User1 _userData = User1();
  bool isLoading = true;
  AdminHomeModel _data = AdminHomeModel();
  List<String> statusData = [
    'semua',
    'diterima',
    'ditolak',
    'menunggu',
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
  void initState() {
    selectedTahun = null;
    setState(() {
      Timer(Duration(seconds: 1), () {
        CallStorage().getUserData().then((value) {
          setState(() {
            print(value.name);
            _userData = value;
            print(_userData.name);
            initData('', '');
          });
        });
      });
    });
    super.initState();
  }

  initData(year, status) async {
    setState(() {
      isLoading = true;
    });
    await CallAdminApi().getAdminHomeData(year, status).then((value) {
      setState(() {
        _data = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/header_admin.png'),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Image(
                          fit: BoxFit.cover,
                          height: 70,
                          width: 70,
                          image: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.notifications_active_outlined,
                              color: Colors.blue[900],
                              size: 30,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Hallo, ${_userData.name ?? ''} !',
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20)),
                    ),
                    InkWell(
                      onTap: () {
                        pushNewScreen(context,
                            screen: Profile(logout), withNavBar: false);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(65)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(65),
                          child: CachedNetworkImage(
                            imageUrl: _userData.avatar ?? '-',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, -1),
                          blurRadius: 8,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.document_scanner,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Surat Masuk   ',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                          child: Text(
                        '${_data.suratMasuk ?? '0'}',
                        style: GoogleFonts.roboto(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.redAccent)),
                      ))
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, -1),
                          blurRadius: 8,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Surat Diproses',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                          child: Text(
                        '${_data.suratDiproses ?? '0'}',
                        style: GoogleFonts.roboto(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.redAccent)),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Surat Balasan',
              style: GoogleFonts.roboto(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  textStyle: TextStyle(
                    color: Colors.grey[700],
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  margin: EdgeInsets.only(left: 25),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton<String>(
                    items: statusData
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(value.toUpperCase(),
                              style: GoogleFonts.roboto(fontSize: 10)),
                        ),
                        value: value,
                      );
                    }).toList(),
                    value: selectedStatus,
                    underline: Container(),
                    hint: Center(child: Text('Choose')),
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
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton<String>(
                    items:
                        tahunData.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(value.toUpperCase(),
                              style: GoogleFonts.roboto(fontSize: 10)),
                        ),
                        value: value,
                      );
                    }).toList(),
                    value: selectedTahun,
                    underline: Container(),
                    icon: Icon(Icons.calendar_today),
                    iconSize: 15,
                    hint: Center(
                        child: Text('Pilih Tahun    ',
                            style: GoogleFonts.roboto(fontSize: 10))),
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
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: isLoading == true
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _data.registrationForms!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(10),
                        color: Colors.grey[100],
                        shadowColor: Colors.black,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideToLeftRoute(
                                    page: StatusPengajuanScreenAdmin(
                                        _data.registrationForms![index])));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 25),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ID: ${_data.registrationForms?[index].id ?? 0}',
                                        style: GoogleFonts.roboto(
                                            fontSize: 10,
                                            textStyle: TextStyle(
                                              color: Colors.grey[500],
                                            )),
                                      ),
                                      Text(
                                        DateFormat('dd MMMM yyyy, HH.mm')
                                            .format(_data
                                                .registrationForms![index]
                                                .createdAt!),
                                        style: GoogleFonts.roboto(
                                            fontSize: 10,
                                            textStyle: TextStyle(
                                              color: Colors.grey[500],
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Nama Pemohon',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    textStyle: TextStyle(
                                                      color: Colors.grey[500],
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                '${_data.registrationForms?[index].user?.name ?? '-'}',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    textStyle: TextStyle(
                                                      color: Colors.black54,
                                                    )),
                                              ),
                                            ]),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Status',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  textStyle: TextStyle(
                                                    color: Colors.grey[500],
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                                '${_data.registrationForms?[index].mailRequest == null ? '-' : _data.registrationForms![index].status!.toUpperCase()}',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    textStyle: TextStyle(
                                                      color: _data
                                                                  .registrationForms?[
                                                                      index]
                                                                  .status ==
                                                              null
                                                          ? Colors.grey
                                                          : _data
                                                                      .registrationForms![
                                                                          index]
                                                                      .mailRequest!
                                                                      .checkMailPermission !=
                                                                  'diterima'
                                                              ? Colors.grey
                                                              : Colors.green,
                                                    ))),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Lampiran',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    textStyle: TextStyle(
                                                      color: Colors.grey[500],
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _data.registrationForms![index]
                                                          .mailRequest?.body !=
                                                      null
                                                  ? InkWell(
                                                      onTap: () {
                                                        pushNewScreen(context,
                                                            screen: PreviewSuratBalasanScreen(
                                                                _data
                                                                    .registrationForms![
                                                                        index]
                                                                    .mailRequest!
                                                                    .id!
                                                                    .toString(),
                                                                'view'),
                                                            withNavBar: false);
                                                      },
                                                      child: Text(
                                                        'Lihat Surat Balasan',
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 12,
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .blueAccent,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline)),
                                                      ),
                                                    )
                                                  : Text('-')
                                            ]),
                                      ),
                                      Expanded(
                                        child: _data.registrationForms?[index]
                                                    .status ==
                                                null
                                            ? Container()
                                            : _data.registrationForms![index]
                                                        .status !=
                                                    'ditolak'
                                                ? Container()
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Alasan ditolak:',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12,
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                )),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                          '${_data.registrationForms?[index].reasonRejection ?? '-'}',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: _data.registrationForms?[index].status ==
                                                                            null
                                                                        ? Colors
                                                                            .grey
                                                                        : _data.registrationForms![index].status !=
                                                                                'diterima'
                                                                            ? Colors.grey
                                                                            : Colors.green,
                                                                  ))),
                                                    ],
                                                  ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                            _data.registrationForms?[index]
                                                        .status ==
                                                    null
                                                ? Container()
                                                : _data
                                                            .registrationForms![
                                                                index]
                                                            .status !=
                                                        'menunggu'
                                                    ? Container()
                                                    : Row(
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .remove_red_eye_outlined,
                                                                  color: Colors
                                                                          .greenAccent[
                                                                      700],
                                                                  size: 15,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                                  child: Text(
                                                                    'Detail',
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                            fontSize:
                                                                                12,
                                                                            textStyle:
                                                                                TextStyle(
                                                                              color: Colors.greenAccent[700],
                                                                            )),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20),
                                                            child: Container(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .redAccent,
                                                                    size: 15,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                    child: Text(
                                                                      'Hapus',
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize: 12,
                                                                          textStyle: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
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
                                      _data.registrationForms?[index].status ==
                                              null
                                          ? Container()
                                          : _data.registrationForms![index]
                                                      .status !=
                                                  'menunggu'
                                              ? Container()
                                              : Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .double_arrow_outlined,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 3),
                                                        child: Text(
                                                          'Balas dengan surat',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 11,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                    ],
                                  )
                                ],
                              )

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Expanded(
                              //       child: Container(
                              //         child: Column(
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 15, 15, 0),
                              //               child:
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              // child:
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              // child:
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 30, 15, 0),
                              //               child: Text(
                              //                 'Lampiran',
                              //                 style: GoogleFonts.roboto(
                              //                     fontSize: 12,
                              //                     textStyle: TextStyle(
                              //                       color: Colors.grey[500],
                              //                     )),
                              //               ),
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 5, 15, 0),
                              //               child: Container(
                              //                 child: Row(
                              //                   children: [
                              //                     Icon(
                              //                       Icons.image,
                              //                       size: 20,
                              //                       color: Colors.orangeAccent,
                              //                     ),
                              //                     SizedBox(
                              //                       width: 5,
                              //                     ),
                              //                     Expanded(
                              //                       child: Text(
                              //                         'Gambar bangunan.png',
                              //                         overflow: TextOverflow.ellipsis,
                              //                         style: GoogleFonts.roboto(
                              //                             fontSize: 12,
                              //                             textStyle: TextStyle(
                              //                               color: Colors.grey[500],
                              //                             )),
                              //                       ),
                              //                     )
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              // child:
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Container(
                              //         child: Column(
                              //           crossAxisAlignment: CrossAxisAlignment.end,
                              //           children: [
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 15, 15, 0),
                              //               child:
                              //             ),
                              //             Divider(
                              //               endIndent: 15,
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              // child:
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              // child:
                              //               ),
                              //             ),
                              //             _data.registrationForms?[index].status == null
                              //                 ? Container()
                              //                 : _data.registrationForms![index].status !=
                              //                         'menunggu'
                              // ?
                              //                         ),
                              //                       )
                              //                     : Container()
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    ));
  }
}
