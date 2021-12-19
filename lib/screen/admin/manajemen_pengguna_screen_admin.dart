import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/admin_permission_model.dart';
import 'package:flutter_application_3/models/manajemen_pengguna_model.dart';
import 'package:flutter_application_3/screen/admin/edit_manajemen_pengguna_screen_admin.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ManajemenPenggunaScreenAdmin extends StatefulWidget {
  const ManajemenPenggunaScreenAdmin({Key? key}) : super(key: key);

  @override
  _ManajemenPenggunaScreenAdminState createState() =>
      _ManajemenPenggunaScreenAdminState();
}

class _ManajemenPenggunaScreenAdminState
    extends State<ManajemenPenggunaScreenAdmin> {
  TextEditingController _searchListController = TextEditingController();
  ManajemenPenggunaModel _data = ManajemenPenggunaModel();
  List<Pengguna>? _searchList;
  bool isLoading = true;
  AdminPermission _adminPermission = AdminPermission();

  initData() async {
    await CallStorage().getUserPermission().then((data) {
      setState(() {
        _adminPermission = data;
      });
    });
    await CallAdminApi().getListPengguna().then((value) {
      setState(() {
        _data = value;
        _searchList = value.users;
        isLoading = false;
      });
    });
  }

  void deletePengguna(int id) async {
    await CallAdminApi().deleteManajemenPengguna(id.toString()).then((value) {
      String _dataDelete = value;
      if (_dataDelete == 'success') {
        Fluttertoast.showToast(
            msg: 'User berhasil dihapus', timeInSecForIosWeb: 2);
        setState(() {
          initData();
        });
      } else if (_dataDelete == 'failed') {
        Fluttertoast.showToast(
            msg: 'User gagal dihapus', timeInSecForIosWeb: 2);
      } else {
        Fluttertoast.showToast(msg: _dataDelete, timeInSecForIosWeb: 2);
      }
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: 
        _adminPermission.manajemenPengguna == 0?
        Center(
          child: Text('Anda tidak memiliki akses ke menu ini.'),
        ):
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Manajemen Pengguna',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(7)),
              child: TextFormField(
                controller: _searchListController,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search), border: InputBorder.none),
              ),
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
                : Expanded(
                    child: Container(
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: _searchList!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(10),
                            color: Colors.grey[100],
                            shadowColor: Colors.black,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(65)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(65),
                                              child: CachedNetworkImage(
                                                imageUrl: _searchList?[index]
                                                        .avatar ??
                                                    '-',
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons.error,
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _searchList?[index].name ?? '-',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    textStyle: TextStyle(
                                                      color: Colors.grey,
                                                    )),
                                              ),
                                              Text(
                                                _searchList![index].app ==
                                                        'admin'
                                                    ? 'Admin'
                                                    : 'User',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    textStyle: TextStyle(
                                                      color: _searchList![index]
                                                                  .app ==
                                                              'admin'
                                                          ? Colors.blue
                                                          : Colors.orange,
                                                    )),
                                              ),
                                              Text(
                                                _searchList?[index].email ??
                                                    '-',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    textStyle: TextStyle(
                                                      color: Colors.grey,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          pushNewScreen(context,
                                              screen:
                                                  EditManajemenPenggunaScreen(
                                                      _searchList![index]));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            child: Icon(
                                              Icons.edit_outlined,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          deletePengguna(
                                              _searchList![index].id!);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
