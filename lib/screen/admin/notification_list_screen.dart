import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/models/notif_model.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
        backgroundColor: ColorPallete.mainBackgroundColor,
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
      backgroundColor: ColorPallete.mainBackgroundColor,
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
                : _data.notifications!.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: _data.notifications!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            thickness: 1,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    returnNotifDate(
                                        _data.notifications![index].createdAt!),
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      _data.notifications?[index].status ==
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          _data.notifications?[index].title ??
                                              '-',
                                          style: GoogleFonts.roboto(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
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

  String returnNotifDate(DateTime dateTime) {
    DateTime today = DateTime.now();

    print("today: ${returnFormatedDate(today)}");
    print(
        "yesterday: ${returnFormatedDate(today.subtract(const Duration(days: 1)))}");
    print("created time: ${returnFormatedDate(dateTime)}");

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
}
