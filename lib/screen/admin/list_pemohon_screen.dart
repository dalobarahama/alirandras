import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/admin/approval_screen.dart';
import 'package:flutter_application_3/screen/admin/detail_status_pemohon.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:intl/intl.dart';

import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';

import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/models/admin_pemohon_model.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ListPemohonScreen extends StatefulWidget {
  const ListPemohonScreen({Key? key}) : super(key: key);

  @override
  _ListPemohonScreenState createState() => _ListPemohonScreenState();
}

class _ListPemohonScreenState extends State<ListPemohonScreen> {
  User1 _userData = User1();
  bool isLoading = true;
  GetListPemohon _data = GetListPemohon();
  @override
  void initState() {
    setState(() {
      Timer(const Duration(seconds: 1), () {
        CallStorage().getUserData().then((value) {
          setState(() {
            print(value.name);
            _userData = value;
            print(_userData.name);
            initData();
          });
        });
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
      initData();
    });
  }

  initData() async {
    await CallAdminApi().getListPemohonData().then((value) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Text(
                'List Permohonan',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              isLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : _data.applicationLetters!.length == 0
                      ? const Center(child: Text('-'))
                      : Container(
                          child: ListView.builder(
                            itemCount: _data.applicationLetters!.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 20),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.all(10),
                                color: Colors.grey[100],
                                shadowColor: Colors.black,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        SlideToLeftRoute(
                                            page: StatusPemohonScreenAdmin(_data
                                                .applicationLetters![index])));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'ID: ' +
                                                  _data
                                                      .applicationLetters![
                                                          index]
                                                      .id!
                                                      .toString(),
                                              style: GoogleFonts.roboto(
                                                  fontSize: 10,
                                                  textStyle: TextStyle(
                                                    color: Colors.grey[500],
                                                  )),
                                            ),
                                            Text(
                                              DateFormat('dd MMMM yy, HH:mm')
                                                  .format(_data
                                                      .applicationLetters![
                                                          index]
                                                      .createdAt!),
                                              style: GoogleFonts.roboto(
                                                  fontSize: 10,
                                                  textStyle: TextStyle(
                                                    color: Colors.grey[500],
                                                  )),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Nama Pemohon',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 12,
                                                        textStyle: TextStyle(
                                                          color:
                                                              Colors.grey[500],
                                                        )),
                                                  ),
                                                  Text(
                                                    _data
                                                        .applicationLetters![
                                                            index]
                                                        .user!
                                                        .name!,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black54,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Status',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 12,
                                                        textStyle: TextStyle(
                                                          color:
                                                              Colors.grey[500],
                                                        )),
                                                  ),
                                                  Text(
                                                    _data
                                                            .applicationLetters![
                                                                index]
                                                            .status ??
                                                        '-',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black54,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: _data
                                                                .applicationLetters![
                                                                    index]
                                                                .status ==
                                                            'menunggu' ||
                                                        _data
                                                                .applicationLetters![
                                                                    index]
                                                                .status ==
                                                            "selesai direvisi"
                                                    ? InkWell(
                                                        onTap: () {
                                                          navigateToApprovalScreen(
                                                              _data
                                                                  .applicationLetters![
                                                                      index]
                                                                  .id!
                                                                  .toString());
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      10),
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7)),
                                                          child: Row(
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                child: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            3),
                                                                child: Text(
                                                                  'Verifikasi',
                                                                  style: GoogleFonts
                                                                      .roboto(
                                                                          fontSize:
                                                                              11,
                                                                          textStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
