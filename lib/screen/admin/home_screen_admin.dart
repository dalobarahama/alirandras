import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/screen/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({Key? key}) : super(key: key);

  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  User _userData = User();
  bool isLoading = true;
  @override
  void initState() {
    setState(() {
      Timer(Duration(seconds: 1), () {
        CallStorage().getUserData().then((value) {
          setState(() {
            _userData = value;
            isLoading = false;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/header_admin.png'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Hello,\nAdministrator!',
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 20)),
                  ),
                  InkWell(
                    onTap: () {
                      pushNewScreen(context,
                          screen: Profile(), withNavBar: false);
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
                          imageUrl: _userData.signature ?? '-',
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
                          textDirection: TextDirection.rtl,
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
                      '999',
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
                          textDirection: TextDirection.rtl,
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
                      '999',
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
            'Surat Pengajuan',
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
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Semua',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[600],
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Pilih Tahun',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey[600],
                        size: 15,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 100),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(10),
                  color: Colors.grey[100],
                  shadowColor: Colors.black,
                  child: Container(
                    height: 200,
                    child: Row(
                      children: [
                        Container(
                          width: 185,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Text(
                                  'ID: 99999999',
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      textStyle: TextStyle(
                                        color: Colors.grey[500],
                                      )),
                                ),
                              ),
                              Divider(
                                indent: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Text(
                                  'Nama Pemohon',
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      textStyle: TextStyle(
                                        color: Colors.grey[500],
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Text(
                                  'Doni Suraya',
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      textStyle: TextStyle(
                                        color: Colors.black54,
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 30, 15, 0),
                                child: Text(
                                  'Lampiran',
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      textStyle: TextStyle(
                                        color: Colors.grey[500],
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 20,
                                        color: Colors.orangeAccent,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Gambar bangunan.png',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              textStyle: TextStyle(
                                                color: Colors.grey[500],
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: Colors.greenAccent,
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
                                                    color: Colors.greenAccent,
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(
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
                                                    textStyle: TextStyle(
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Text(
                                  '20 September 2021, 09.41',
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      textStyle: TextStyle(
                                        color: Colors.grey[500],
                                      )),
                                ),
                              ),
                              Divider(
                                endIndent: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Text(
                                  'Status',
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      textStyle: TextStyle(
                                        color: Colors.grey[500],
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Text(
                                  'Disetujui',
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      textStyle: TextStyle(
                                        color: Colors.green,
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 70, 15, 0),
                                child: Container(
                                  height: 30,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Icon(
                                          Icons.double_arrow_outlined,
                                          color: Colors.white70,
                                          size: 15,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          'Balas dengan surat',
                                          style: GoogleFonts.roboto(
                                              fontSize: 11,
                                              textStyle: TextStyle(
                                                color: Colors.white70,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
