import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/admin/list_formulir_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/list_penohon_screen.dart';
import 'package:flutter_application_3/screen/admin/manajemen_pengguna_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/setting_surat_pengajuan_screen_admin.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_application_3/screen/admin/home_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/upload_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/detail_status_pengajuan_screen_admin.dart';
import 'package:flutter_application_3/screen/Profile.dart';

class MainMenuScreenAdmin extends StatefulWidget {
  const MainMenuScreenAdmin({Key? key}) : super(key: key);

  @override
  _MainMenuScreenAdminState createState() => _MainMenuScreenAdminState();
}

class _MainMenuScreenAdminState extends State<MainMenuScreenAdmin> {
  List<Widget> _screenList() {
    return [
      HomeScreenAdmin(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        screens: _screenList(),
        items: _itemList(),
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
