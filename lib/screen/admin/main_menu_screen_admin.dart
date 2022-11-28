import 'package:flutter/material.dart';
import 'package:flutter_application_3/aliran_dras_icon_icons.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/screen/admin/list_pemohon_screen.dart';
import 'package:flutter_application_3/screen/admin/manajemen_pengguna_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/setting_surat_pengajuan_screen_admin.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_3/screen/admin/home_screen_admin.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
    Navigator.pushReplacement(context, SlideToRightRoute(page: const Log_in()));
    Fluttertoast.showToast(msg: 'Your login session is expired.');
  }

  List<Widget> _screenList() {
    return [
      HomeScreenAdmin(logout),
      const ListPemohonScreen(),
      const ManajemenPenggunaScreenAdmin(),
      const SettingSuratPengajuanScreenAdmin(),
    ];
  }

  List<PersistentBottomNavBarItem> _itemList() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            AliranDrasIcon.list_alt,
            color: _controller.index == 0 ? Colors.blueAccent : Colors.grey,
            size: 18,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Surat Balasan'),
      PersistentBottomNavBarItem(
          icon: Icon(
            AliranDrasIcon.file_alt,
            color: _controller.index == 1 ? Colors.blueAccent : Colors.grey,
            size: 18,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Pemohon'),
      PersistentBottomNavBarItem(
          icon: Icon(
            AliranDrasIcon.user_cog,
            color: _controller.index == 2 ? Colors.blueAccent : Colors.grey,
            size: 18,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Pengguna'),
      PersistentBottomNavBarItem(
          icon: Icon(
            AliranDrasIcon.cog,
            color: _controller.index == 3 ? Colors.blueAccent : Colors.grey,
            size: 18,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
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
                title: const Text('logout App'),
                content: const Text('Do you want to logout an App?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => logout(),
                    //return true when click on "Yes"
                    child: const Text('Yes'),
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
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: PersistentTabView(
          context,
          screens: _screenList(),
          items: _itemList(),
          controller: _controller,
          onItemSelected: (a) {
            setState(() {});
          },
          screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              duration: Duration(milliseconds: 300)),
          backgroundColor: Colors.white,
          navBarStyle: NavBarStyle.style6,
          stateManagement: false,
          decoration: NavBarDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, -1),
                    blurRadius: 6)
              ]),
        ),
      ),
    );
  }
}
