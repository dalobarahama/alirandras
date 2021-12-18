import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/models/setting_pengajuan.dart';
import 'package:flutter_application_3/models/setting_pengajuan_user_model.dart';
import 'package:flutter_application_3/models/setting_update_post_model.dart';
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
  bool isUpdating = false;
  SettingPengajuanModel _data = SettingPengajuanModel();

  SettingPengajuanListUser _userList = SettingPengajuanListUser();
  List<SettingUser> _selectedUser = <SettingUser>[];

  initData() async {
    await CallAdminApi().getSettingPengajuan().then((value) {
      setState(() {
        _data = value;
      });
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: 'Something wrong, try again later...');
    });

    await CallAdminApi().getListUserSetting().then((value) {
      setState(() {
        _userList = value;

        for (var i = 0; i < _data.settings!.length; i++) {
          for (var j = 0; j < _userList.users!.length; j++) {
            if (_data.settings![i].user!.id == _userList.users![j].id) {
              _selectedUser.insert(i, _userList.users![j]);
            }
          }
        }
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

  submit() async {
    setState(() {
      isUpdating = true;
    });
    SettingUserPost _postData = SettingUserPost();
    List<UserId> _listPost = <UserId>[];
    for (var i = 0; i < _selectedUser.length; i++) {
      _listPost.add(UserId(userId: _selectedUser[i].id!));
    }
    _postData.userIds = _listPost;
    await CallAdminApi().updateSetting(_postData).then((value) {
      if (value == 'success') {
        Fluttertoast.showToast(msg: 'Setting updated!');
      } else {
        Fluttertoast.showToast(msg: 'Something Wrong! $value');
      }
      setState(() {
        isUpdating = false;
      });
    }).onError((error, stackTrace) {});
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
                'Setting Surat Balasan',
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
                        itemCount: _selectedUser.length + 1,
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
                                            padding:
                                                index == _selectedUser.length
                                                    ? EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 15)
                                                    : EdgeInsets.symmetric(
                                                        horizontal: 15),
                                            decoration: BoxDecoration(
                                                color: index ==
                                                        _selectedUser.length
                                                    ? Colors.transparent
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: index == _selectedUser.length
                                                ? InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedUser.add(
                                                            _userList
                                                                .users![0]);
                                                      });
                                                    },
                                                    child: Text(
                                                      '+ Tambah Alur',
                                                      style: GoogleFonts.roboto(
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                : _userList.users == null
                                                    ? Container(
                                                        height: 45,
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8),
                                                        child: Text(
                                                            'Pilih User',
                                                            style: GoogleFonts.roboto(
                                                                color: Colors
                                                                    .grey[600],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15)),
                                                      )
                                                    : DropdownButton<
                                                        SettingUser>(
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54),
                                                        onChanged: (value) =>
                                                            setState(() {
                                                          _selectedUser[index] =
                                                              value!;
                                                        }),
                                                        value: _selectedUser[
                                                            index],
                                                        hint: Text(
                                                          'Pilih Kelurahan',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                        ),
                                                        items: _userList.users!
                                                            .map((SettingUser
                                                                value) {
                                                          return new DropdownMenuItem<
                                                              SettingUser>(
                                                            value: value,
                                                            child: new Text(
                                                                value.name!),
                                                          );
                                                        }).toList(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        isExpanded: true,
                                                        underline:
                                                            SizedBox.shrink(),
                                                      )),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                index == _selectedUser.length
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedUser.removeAt(index);
                                          });
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.grey[600],
                                          size: 20,
                                        ),
                                      )
                              ],
                            ),
                          );
                        },
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                    ),
              InkWell(
                onTap: () {
                  submit();
                },
                child: Container(
                  height: 60,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 20),
                  child: Center(
                    child: isUpdating
                        ? Container(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Update',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
