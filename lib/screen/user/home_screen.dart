import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/user/form_pendaftaran.dart';
import 'package:flutter_application_3/screen/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  User _userData = User();
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var overvlow;
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.menu,
                                color: Colors.blue[900],
                                size: 30,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
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
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Hello, ',
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    textStyle: TextStyle(
                                      color: Colors.lightBlue[700],
                                    )),
                              ),
                              Text(
                                _userData.name!,
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue[700],
                                    )),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Profile();
                              }));
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(45)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(45),
                                child: CachedNetworkImage(
                                  imageUrl: _userData.signature!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(overflow: Overflow.visible, children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/bg_home.png'),
                              fit: BoxFit.fill)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Text(
                                  'Selamat Datang, di ',
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                Text(
                                  'ALIRANDRAS ',
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Aplikasi layanan informasi/rekomendasi',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                Text(
                                  'drainase ekspress',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: 170,
                        width: 360,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, right: 210),
                              child: Container(
                                child: Text(
                                  'Alur Proses',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.lightBlue),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.send_sharp,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '1. Pengajuan',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      '   ',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.list,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '2. Isi formulir',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      '   ',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.lock_clock,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '3. Menunggu',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      'pemberitahuan',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '4. Selalu cek',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      'pemberitahuan',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.nature_people_rounded,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '5. Disetujui',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      'dan selesai',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      bottom: -110,
                      left: 10,
                      right: 10,
                    ),
                  ]),
                  SizedBox(
                    height: 120,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Form_pendaftaran();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 200,
                        width: 360,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.lightBlue.shade100, Colors.blue],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 200,
                                  width: 100,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/upload_dokumen.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Text(
                                      'Isi Formulir Pengajuan',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Klik untuk ajukan formulir pengajuan',
                                      style: GoogleFonts.roboto(
                                          fontSize: 10,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 140, top: 10),
                                      child: Container(
                                        child: Icon(
                                          Icons.arrow_right_alt_outlined,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
  }
}
