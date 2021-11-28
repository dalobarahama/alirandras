import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/screen/cek_status_pengajuan.dart';
import 'package:flutter_application_3/screen/detail_card_statuspengajuan.dart';

import 'package:flutter_application_3/screen/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  List<Widget> _screenList() {
    return [
      Home(),
      Cek_status_pengajuan(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _itemList() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.document_scanner, size: 25),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Home'),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.paste,
            size: 25,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Cek Status Pengajuan'),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person,
            size: 25,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Profile'),
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
