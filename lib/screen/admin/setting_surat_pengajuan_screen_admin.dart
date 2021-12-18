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
  List<SettingPengajuanData>? _selectedName = <SettingPengajuanData>[];

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

  void addIndex() {
    setState(() {
      _data.settings!.add(_data.settings![0]);
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
                          for (int i = 0; i < _data.settings!.length; i++) {
                            _selectedName!.add(_data.settings![i]);
                            print(_selectedName![i].user!.name);
                          }
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
                                          child: index != _data.settings!.length
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black38),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  padding: EdgeInsets.only(
                                                      left: 12, right: 24),
                                                  child: DropdownButton<
                                                      SettingPengajuanData>(
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54),
                                                    onChanged: (value) =>
                                                        setState(() {
                                                      _selectedName![index] =
                                                          value!;
                                                    }),
                                                    value:
                                                        _selectedName![index],
                                                    items: _selectedName!.map(
                                                        (SettingPengajuanData
                                                            value) {
                                                      return new DropdownMenuItem<
                                                          SettingPengajuanData>(
                                                        value: value,
                                                        child: new Text(
                                                            value.user!.name!),
                                                      );
                                                    }).toList(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    isExpanded: true,
                                                    underline:
                                                        SizedBox.shrink(),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    addIndex();
                                                  },
                                                  child: Text('+')),
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

  Widget _builDropdown(int index1) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(left: 12, right: 24),
      child: DropdownButton<SettingPengajuanData>(
        style: TextStyle(fontSize: 12, color: Colors.black54),
        onChanged: (value) => setState(() {
          _selectedName![index1] = value!;
        }),
        value: _selectedName![index1],
        items: _selectedName!.map((SettingPengajuanData value) {
          return new DropdownMenuItem<SettingPengajuanData>(
            value: value,
            child: new Text(value.user!.name!),
          );
        }).toList(),
        borderRadius: BorderRadius.circular(5),
        isExpanded: true,
        underline: SizedBox.shrink(),
      ),
    );
  }
}
