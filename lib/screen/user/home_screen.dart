import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/admin/notification_list_screen.dart';
import 'package:flutter_application_3/screen/user/form_pendaftaran.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  User1 _userData = User1();
  @override
  void initState() {
    initData();
    // TODO: implement initState
    super.initState();
  }

  initData() {
    setState(() {
      Timer(const Duration(seconds: 1), () {
        CallStorage().getUserData().then((value) {
          setState(() {
            _userData = value;
            isLoading = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var overvlow;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Image(
                            fit: BoxFit.cover,
                            height: 70,
                            width: 70,
                            image: AssetImage('assets/images/logo.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: const NotificationListScreen(),
                                  withNavBar: false);
                            },
                            child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.notifications_active_outlined,
                                  color: Colors.blue[900],
                                  size: 30,
                                )),
                          ),
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
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return Profile();
                              // }));
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(45)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(45),
                                child: isLoading == true
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : CachedNetworkImage(
                                        imageUrl: _userData.avatar ?? '-',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(clipBehavior: Clip.none, children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/bg_home.png'),
                              fit: BoxFit.fill)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
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
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                Text(
                                  'ALIRANDRAS ',
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
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
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                Text(
                                  'drainase ekspress',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      textStyle: const TextStyle(
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
                      bottom: -110,
                      left: 10,
                      right: 10,
                      child: Container(
                        height: 170,
                        width: 360,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFCFE7FF),
                              Colors.white,
                              Color(0xFFCFE7FF)
                            ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 35),
                              child: const Text(
                                'Alur Proses',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.lightBlue),
                              ),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/navigation_line.svg',
                                      height: 30,
                                      width: 30,
                                      color: Colors.lightBlue,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      '1. Pengajuan',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    const Text(
                                      '   ',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/draft_line.svg',
                                      height: 30,
                                      width: 30,
                                      color: Colors.lightBlue,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      '2. Isi formulir',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    const Text(
                                      '   ',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/clock.svg',
                                      height: 30,
                                      width: 30,
                                      color: Colors.lightBlue,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      '3. Menunggu',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    const Text(
                                      'pemberitahuan',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/circle.svg',
                                      color: Colors.lightBlue,
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      '4. Selalu cek',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    const Text(
                                      'pemberitahuan',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/user_follow.svg',
                                      color: Colors.lightBlue,
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      '5. Disetujui',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 10),
                                    ),
                                    const Text(
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
                    ),
                  ]),
                  const SizedBox(
                    height: 120,
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const Form_pendaftaran(), withNavBar: false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 200,
                        width: double.infinity,
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
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 200,
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/upload_dokumen.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Isi Formulir Pengajuan',
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Klik untuk ajukan formulir pengajuan',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Container(
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 25,
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
  }
}
