import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class RejectScreen extends StatefulWidget {
  RejectScreen(this.type, this.id);
  String type, id;
  @override
  _RejectScreenState createState() => _RejectScreenState(this.type, this.id);
}

class _RejectScreenState extends State<RejectScreen> {
  _RejectScreenState(this.type, this.id);
  String type, id;
  TextEditingController _reason = TextEditingController();
  bool isLoading = false;

  reject() async {
    setState(() {
      isLoading = true;
    });
    if (type == 'permohonan') {
      await CallAdminApi().rejectPermohonan(id, _reason.text).then((value) {
        Fluttertoast.showToast(msg: 'Surat Permohonan Rejected!');
        Navigator.pop(context, 'true');
      });
    } else {
      await CallAdminApi().rejectPengajuan(id, _reason.text).then((value) {
        Fluttertoast.showToast(msg: 'Surat Pengajuan Rejected!');
        Navigator.pop(context, 'true');
      });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            children: [
              TextFormField(
                controller: _reason,
                maxLines: 10,
                decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  hintText: 'Ketik alasan ditolak...',
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      isLoading
                          ? Fluttertoast.showToast(msg: 'Please wait...')
                          : reject();
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
                          : Center(
                              child: Text(
                                'Submit',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
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
                      child: Center(
                        child: Text(
                          'Kembali',
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
