import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/screen/admin/reject_screen.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ApprovalScreen extends StatefulWidget {
  ApprovalScreen(this.type, this.id);
  String type, id;

  @override
  _ApprovalScreenState createState() =>
      _ApprovalScreenState(this.type, this.id);
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  _ApprovalScreenState(this.type, this.id);
  String type, id;
  bool isLoading = false;

  approve() async {
    setState(() {
      isLoading = true;
    });
    if (type == 'permohonan') {
      await CallAdminApi().approvePermohonan(id).then((value) {
        Fluttertoast.showToast(msg: 'Surat Permohonan Approved!');
        Navigator.pop(context);
      });
    } else {
      await CallAdminApi().approvePengajuan(id).then((value) {
        Fluttertoast.showToast(msg: 'Surat Pengajuan Approved!');
        Navigator.pop(context);
      });
    }
  }

  navigateToRejectScreen() async {
    var res = await Navigator.push(
        context, SlideToLeftRoute(page: RejectScreen(type, id)));
    if (res == 'true') {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/approval.png'),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    isLoading
                        ? Fluttertoast.showToast(msg: 'Please wait...')
                        : approve();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 5,
                              offset: Offset(3, 3))
                        ]),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Setuju',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    navigateToRejectScreen();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 5,
                              offset: Offset(3, 3))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Tolak',
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
