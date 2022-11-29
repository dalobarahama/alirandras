import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/models/notif_model.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  NotifModel _data = NotifModel();
  bool isLoading = true;

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    await CallAdminApi().getNotificationList().then((value) {
      setState(() {
        _data = value;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      isLoading = false;
      Fluttertoast.showToast(msg: 'Something wrong, try again later..');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Notifications",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Container(
                height: 100,
                child: const Center(child: CircularProgressIndicator()))
            : _data.notifications == null
                ? Container(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Notification.',
                        style: GoogleFonts.roboto(),
                      ),
                    ),
                  )
                : _data.notifications!.length > 0
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _data.notifications!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _data.notifications?[index].title ??
                                            '-',
                                        style: GoogleFonts.roboto(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    _data.notifications?[index].status ==
                                            'diterima'
                                        ? const Icon(Icons.check_circle_outline,
                                            size: 30, color: Colors.green)
                                        : const Icon(Icons.close_outlined,
                                            size: 30, color: Colors.red),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)));
                          },
                        ),
                      )
                    : Container(
                        height: 100,
                        child: Center(
                          child: Text(
                            'No Notification.',
                            style: GoogleFonts.roboto(),
                          ),
                        ),
                      ),
      ),
    );
  }
}
