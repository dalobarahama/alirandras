import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/admin/notification_list_screen.dart';
import 'package:flutter_application_3/screen/user/form_pendaftaran.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../helper/admin_api_helper.dart';
import '../../models/notif_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  User1 _userData = User1();

  NotifModel notificationData = NotifModel();

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    await CallStorage().getUserData().then((value) {
      setState(() {
        _userData = value;
        isLoading = false;
      });
    });

    await CallAdminApi().getNotificationList().then((value) {
      setState(() {
        notificationData = value;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      isLoading = false;
      Fluttertoast.showToast(msg: 'Something wrong, try again later..');
    });
  }

  Future<void> refresh() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: ColorPallete.mainBackgroundColor,
            body: RefreshIndicator(
              key: refreshKey,
              onRefresh: () => refresh(),
              child: SingleChildScrollView(
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
                                          imageUrl: _userData.avatar ??
                                              "https://alirandras.inotive.id",
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
                                  ),
                                ),
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
                              ),
                            ),
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
                            screen: const Form_pendaftaran(),
                            withNavBar: false);
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
                    Container(
                      height: 450,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(
                                  0,
                                  -1,
                                ),
                                blurRadius: 4)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'Recent Notification',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          notificationData.notifications == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      notificationData.notifications?.length,
                                  itemBuilder: (context, index) {
                                    if (index < 3) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              returnNotifDate(notificationData
                                                  .notifications![index]
                                                  .createdAt!),
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    parseHtmlString(
                                                        notificationData
                                                            .notifications![
                                                                index]
                                                            .title!),
                                                    style: GoogleFonts.roboto(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                notificationData
                                                            .notifications?[
                                                                index]
                                                            .status ==
                                                        'diterima'
                                                    ? const ImageIcon(
                                                        AssetImage(
                                                            'assets/icons/icon_notification_accepted.png'),
                                                        size: 20,
                                                        color: Colors.green)
                                                    : const ImageIcon(
                                                        AssetImage(
                                                            'assets/icons/icon_notification_decline.png'),
                                                        size: 20,
                                                        color: Colors.red),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  String returnNotifDate(DateTime dateTime) {
    DateTime today = DateTime.now();

    if (returnFormatedDate(dateTime) == returnFormatedDate(today)) {
      return "Today";
    } else if (returnFormatedDate(today.subtract(const Duration(days: 1))) ==
        returnFormatedDate(dateTime)) {
      return "Yesterday";
    } else {
      return returnFormatedDate(dateTime);
    }
  }

  String returnFormatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement!.text;

    return parsedString;
  }
}
