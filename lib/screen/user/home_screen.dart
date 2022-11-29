import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/admin/notification_list_screen.dart';
import 'package:flutter_application_3/screen/user/form_pendaftaran.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
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
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: ColorPallete.mainBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/header_new.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
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
                                            Image.asset(
                                                'assets/images/default_profile_pic.png'),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Hello ',
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            Text(
                              _userData.name!,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: const NotificationListScreen(),
                                withNavBar: false);
                          },
                          child: const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 25,
                          left: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                'Welcome to',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Alirandras App',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ColorPallete.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/banner_alur_pengajuan.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const Form_pendaftaran(), withNavBar: false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.edit_note_sharp,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Isi Formulir Pengajuan',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
