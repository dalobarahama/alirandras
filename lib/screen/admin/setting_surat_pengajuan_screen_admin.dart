import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/models/setting_pengajuan.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';

class SettingSuratPengajuanScreenAdmin extends StatefulWidget {
  const SettingSuratPengajuanScreenAdmin({Key? key}) : super(key: key);

  @override
  _SettingSuratPengajuanScreenAdminState createState() =>
      _SettingSuratPengajuanScreenAdminState();
}

class _SettingSuratPengajuanScreenAdminState
    extends State<SettingSuratPengajuanScreenAdmin> {
  bool isLoading = true;
  SettingPengajuanModel _data = SettingPengajuanModel();

  initData() async {
    await CallAdminApi().getSettingPengajuan().then((value) {
      setState(() {
        _data = value;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: 'Something wrong, try again later...');
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                'Setting Surat Pengajuan ${_data.status}',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Atur alur pengajuan',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                  color: Colors.grey,
                )),
              ),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? Container(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        itemCount: _data.settings!.length + 1,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        '${index + 1}',
                                        style: GoogleFonts.roboto(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: index ==
                                                      _data.settings!.length
                                                  ? Colors.transparent
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            index == _data.settings!.length
                                                ? '+ Tambah Alur'
                                                : _data.settings?[index].user
                                                        ?.name ??
                                                    '-',
                                            style: GoogleFonts.roboto(
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                index == _data.settings!.length
                                    ? Container()
                                    : Icon(
                                        Icons.close,
                                        color: Colors.grey[600],
                                        size: 20,
                                      )
                              ],
                            ),
                          );
                        },
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
