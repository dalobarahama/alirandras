import 'package:flutter_application_3/aliran_dras_icon_icons.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/screen/log_in.dart';
import 'package:flutter_application_3/screen/user/cek_status_pengajuan.dart';
import 'package:flutter_application_3/screen/user/detail_card_statuspengajuan.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:flutter_application_3/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/profile.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
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
      Home(),
      Cek_status_pengajuan(),
      Profile(logout),
    ];
  }

  List<PersistentBottomNavBarItem> _itemList() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            AliranDrasIcon.home,
            color: _controller.index == 0 ? Colors.blueAccent : Colors.grey,
            size: 18,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Home'),
      PersistentBottomNavBarItem(
          icon: Icon(
            AliranDrasIcon.doc_text_inv,
            color: _controller.index == 1 ? Colors.blueAccent : Colors.grey,
            size: 18,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Cek Status Pengajuan'),
      PersistentBottomNavBarItem(
          icon: Icon(
            AliranDrasIcon.user,
            color: _controller.index == 2 ? Colors.blueAccent : Colors.grey,
            size: 18,
          ),
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          title: 'Profile'),
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
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: PersistentTabView(
          context,
          screens: _screenList(),
          items: _itemList(),
          onItemSelected: (a) {
            setState(() {});
          },
          controller: _controller,
          screenTransitionAnimation: ScreenTransitionAnimation(
              animateTabTransition: true,
              duration: Duration(milliseconds: 300)),
          backgroundColor: Colors.white,
          navBarStyle: NavBarStyle.style6,
          stateManagement: false,
          decoration: NavBarDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, -1),
                    blurRadius: 6)
              ]),
        ),
      ),
    );
  }
}
