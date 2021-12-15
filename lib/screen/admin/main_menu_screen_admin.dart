import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/screen/admin/list_formulir_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/list_pemohon_screen.dart';
import 'package:flutter_application_3/screen/admin/manajemen_pengguna_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/setting_surat_pengajuan_screen_admin.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_application_3/screen/admin/home_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/upload_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/detail_status_pengajuan_screen_admin.dart';
import 'package:flutter_application_3/screen/Profile.dart';

import '../log_in.dart';

class MainMenuScreenAdmin extends StatefulWidget {
  const MainMenuScreenAdmin({Key? key}) : super(key: key);

  @override
  _MainMenuScreenAdminState createState() => _MainMenuScreenAdminState();
}

class _MainMenuScreenAdminState extends State<MainMenuScreenAdmin> {
  PersistentTabController _controller = PersistentTabController();
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  void logout() async {
    await CallStorage().logout();
    Navigator.pushReplacement(context, SlideToRightRoute(page: Log_in()));
    Fluttertoast.showToast(msg: 'Your login session is expired.');
  }

  List<Widget> _screenList() {
    return [
      HomeScreenAdmin(logout),
      ListPemohonScreen(),
      ManajemenPenggunaScreenAdmin(),
      SettingSuratPengajuanScreenAdmin(),
    ];
  }

  List<PersistentBottomNavBarItem> _itemList() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.document_scanner, size: 25),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Surat Pengajuan'),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.file_present_outlined,
            size: 25,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Pemohon'),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.paste,
            size: 25,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Pengguna'),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.settings_outlined,
            size: 25,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          textStyle: TextStyle(
            fontSize: 8,
          ),
          title: 'Setting'),
    ];
  }

  Future<bool> showExitPopup() async {
    return _controller.index == 0
        ? await showDialog(
              //show confirm dialogue
              //the return value will be from "Yes" or "No" options
              context: context,
              builder: (context) => AlertDialog(
                title: Text('logout App'),
                content: Text('Do you want to logout an App?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => logout(),
                    //return true when click on "Yes"
                    child: Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false
        : _controller.index =
            0; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        screens: _screenList(),
        items: _itemList(),
        controller: _controller,
        screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true, duration: Duration(milliseconds: 300)),
        backgroundColor: Colors.white,
        navBarStyle: NavBarStyle.style6,
        stateManagement: true,
        decoration: NavBarDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, -1),
                  blurRadius: 6)
            ]),
      ),
    );
  }
}
