import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:flutter_application_3/models/admin_home_model.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/screen/admin/detail_status_pengajuan_screen_admin.dart';
import 'package:flutter_application_3/screen/admin/notification_list_screen.dart';
import 'package:flutter_application_3/screen/admin/preview_surat_balasan_screen_new.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreenAdmin extends StatefulWidget {
  Function logout;
  HomeScreenAdmin(this.logout);
  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState(this.logout);
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  Function logout;
  _HomeScreenAdminState(this.logout);
  User1 _userData = User1();
  bool isLoading = true;
  AdminHomeModel _data = AdminHomeModel();

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  TextEditingController _reason = TextEditingController();

  List<String> statusData = [
    'semua',
    'diterima',
    'ditolak',
    'diproses',
    'selesai direvisi'
  ];
  String selectedStatus = 'semua';
  List<String> tahunData = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030'
  ];
  String? selectedTahun;

  @override
  void initState() {
    selectedTahun = null;
    CallStorage().getUserData().then((value) {
      print(value.name);
      _userData = value;
      print(_userData.position);
      initData('', '');
    });
    super.initState();
  }

  initData(year, status) async {
    setState(() {
      isLoading = true;
    });
    await CallAdminApi().getAdminHomeData(year, status).then((value) {
      setState(() {
        _data = value;
        isLoading = false;
      });
    });
  }

  approve(String type, String id) async {
    setState(() {
      isLoading = true;
    });
    if (type == 'permohonan') {
      await CallAdminApi().approvePermohonan(id).then((value) {
        if (value == 'success') {
          Fluttertoast.showToast(msg: 'Surat Permohonan Approved!');
          setState(() {
            isLoading = false;
          });
        } else {
          Fluttertoast.showToast(msg: 'Gagal di Approved!');
        }
      });
    } else {
      await CallAdminApi().approvePengajuan(id).then((value) {
        Fluttertoast.showToast(msg: 'Surat Pengajuan Approved!');
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  reject(String type, String id) async {
    if (_reason.text.length > 0) {
      setState(() {
        isLoading = true;
      });
      if (type == 'permohonan') {
        await CallAdminApi().rejectPermohonan(id, _reason.text).then((value) {
          _reason.clear();
          Fluttertoast.showToast(msg: 'Surat Permohonan Rejected!');
          Navigator.of(context, rootNavigator: true).pop();
          setState(() {
            isLoading = false;
          });
        });
      } else {
        await CallAdminApi().rejectPengajuan(id, _reason.text).then((value) {
          _reason.clear();
          Fluttertoast.showToast(msg: 'Surat Pengajuan Rejected!');
          Navigator.of(context, rootNavigator: true).pop();
          setState(() {
            isLoading = false;
          });
        });
      }
    } else {
      Fluttertoast.showToast(msg: 'Mohon isi kolom alasan terlebih dahulu..');
    }
  }

  navigateToApproval(indexs) async {
    var res = await PersistentNavBarNavigator.pushNewScreen(context,
        screen: PreviewSuratBalasanScreenNew(
            _data.registrationForms![indexs].mailRequest!.id!.toString(),
            'process',
            _data.registrationForms![indexs].id.toString()),
        withNavBar: false);
    setState(() {
      isLoading = true;
    });
    Timer(const Duration(seconds: 2), () {
      initData('', '');
    });
  }

  Future<void> refresh() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      initData('', '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.mainBackgroundColor,
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () => refresh(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                      'assets/images/header_new.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 20,
                    child: Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: isLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : CachedNetworkImage(
                                    imageUrl: _userData.avatar ?? '-',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/images/default_profile_pic.png'),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Hello ',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "${_userData.name}",
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 90,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const NotificationListScreen(),
                            withNavBar: false);
                      },
                      child: const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: -60,
                    child: Container(
                      height: 150,
                      width: 300,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/header_new.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, -1),
                            blurRadius: 8,
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Menunggu Verifikasi',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              '${_data.suratDiproses ?? '0'}',
                              style: GoogleFonts.roboto(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 42,
                    width: 135,
                    margin: const EdgeInsets.only(left: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    child: DropdownButton<String>(
                      items: statusData
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              value.toUpperCase(),
                              style: GoogleFonts.roboto(fontSize: 12),
                            ),
                          ),
                        );
                      }).toList(),
                      value: selectedStatus,
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      hint: const Center(child: Text('Choose')),
                      onChanged: (e) {
                        setState(() {
                          String? tempTahun;
                          String? temptStatus;
                          selectedStatus = e!.toLowerCase();
                          selectedTahun == null
                              ? tempTahun = ''
                              : tempTahun = selectedTahun;
                          selectedStatus == 'semua'
                              ? temptStatus = ''
                              : temptStatus = selectedStatus;
                          initData(tempTahun, temptStatus);
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 42,
                    width: 135,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    child: DropdownButton<String>(
                      items: tahunData
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              value.toUpperCase(),
                              style: GoogleFonts.roboto(fontSize: 12),
                            ),
                          ),
                        );
                      }).toList(),
                      value: selectedTahun,
                      underline: Container(),
                      icon: const Icon(Icons.calendar_today),
                      iconSize: 15,
                      hint: Text(
                        'Pilih Tahun',
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      onChanged: (e) {
                        setState(() {
                          String? tempTahun;
                          String? temptStatus;
                          selectedTahun = e!.toLowerCase();
                          selectedTahun == null
                              ? tempTahun = ''
                              : tempTahun = selectedTahun;
                          selectedStatus == 'semua'
                              ? temptStatus = ''
                              : temptStatus = selectedStatus;
                          initData(tempTahun, temptStatus);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: isLoading == true
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _data.registrationForms!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 100),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            margin: const EdgeInsets.all(10),
                            color: Colors.white,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat('dd MMMM yyyy, HH.mm')
                                                .format(_data
                                                    .registrationForms![index]
                                                    .createdAt!),
                                            style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              textStyle: TextStyle(
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'ID: ${_data.registrationForms?[index].id ?? 0}',
                                            style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              textStyle: TextStyle(
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Nama Pengguna',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  _data
                                                          .registrationForms?[
                                                              index]
                                                          .user
                                                          ?.name ??
                                                      '-',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    textStyle: const TextStyle(
                                                      color: ColorPallete
                                                          .mainColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Status',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  _data
                                                      .registrationForms![index]
                                                      .status!
                                                      .toUpperCase(),
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    textStyle: TextStyle(
                                                      color: _data
                                                                  .registrationForms![
                                                                      index]
                                                                  .status !=
                                                              'diterima'
                                                          ? Colors.grey
                                                          : Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Lampiran',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  _data
                                                              .registrationForms![
                                                                  index]
                                                              .mailRequest
                                                              ?.body !=
                                                          null
                                                      ? InkWell(
                                                          onTap: () {
                                                            PersistentNavBarNavigator.pushNewScreen(
                                                                context,
                                                                screen: PreviewSuratBalasanScreenNew(
                                                                    _data
                                                                        .registrationForms![
                                                                            index]
                                                                        .mailRequest!
                                                                        .id!
                                                                        .toString(),
                                                                    'view',
                                                                    _data
                                                                        .registrationForms![
                                                                            index]
                                                                        .id
                                                                        .toString()),
                                                                withNavBar:
                                                                    false);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/images/pdf_icon.png',
                                                                height: 30,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'Dokumen Surat',
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontSize: 12,
                                                                  textStyle: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const Text('-')
                                                ]),
                                          ),
                                          Expanded(
                                            child: _data
                                                        .registrationForms?[
                                                            index]
                                                        .status ==
                                                    null
                                                ? Container()
                                                : _data
                                                            .registrationForms![
                                                                index]
                                                            .status !=
                                                        'ditolak'
                                                    ? Container()
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Alasan ditolak:',
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        14,
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            _data
                                                                    .registrationForms?[
                                                                        index]
                                                                    .reasonRejection ??
                                                                '-',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 14,
                                                              textStyle:
                                                                  TextStyle(
                                                                color: _data
                                                                            .registrationForms?[
                                                                                index]
                                                                            .status ==
                                                                        null
                                                                    ? Colors
                                                                        .grey
                                                                    : _data.registrationForms![index].status !=
                                                                            'diterima'
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _data
                                                        .registrationForms?[
                                                            index]
                                                        .status ==
                                                    null
                                                ? Container()
                                                : _data
                                                            .registrationForms![
                                                                index]
                                                            .status !=
                                                        'diproses'
                                                    ? Container()
                                                    : Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .remove_red_eye_outlined,
                                                                color: Colors
                                                                        .greenAccent[
                                                                    700],
                                                                size: 15,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                child: Text(
                                                                  'Detail',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    fontSize:
                                                                        12,
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .greenAccent[
                                                                          700],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20),
                                                            child: Container(
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .redAccent,
                                                                    size: 15,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                    child: Text(
                                                                      'Hapus',
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize: 12,
                                                                          textStyle: const TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                          ),
                                          _data.registrationForms?[index]
                                                      .mailRequest ==
                                                  null
                                              ? Container()
                                              : _data
                                                          .registrationForms?[
                                                              index]
                                                          .mailRequest!
                                                          .checkMailPermission ==
                                                      null
                                                  ? Container()
                                                  : _data
                                                              .registrationForms![
                                                                  index]
                                                              .mailRequest!
                                                              .checkMailPermission!
                                                              .status !=
                                                          'diproses'
                                                      ? Container()
                                                      : _data
                                                                  .registrationForms![
                                                                      index]
                                                                  .mailRequest
                                                                  ?.body ==
                                                              null
                                                          ? Container()
                                                          : InkWell(
                                                              onTap: () {
                                                                navigateToApproval(
                                                                    index);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Tindak Lanjuti',
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      fontSize:
                                                                          11,
                                                                      textStyle:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              PersistentNavBarNavigator.pushNewScreen(
                                                  context,
                                                  screen:
                                                      StatusPengajuanScreenAdmin(
                                                          _data.registrationForms![
                                                              index]),
                                                  withNavBar: false);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(6),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    color: Colors.grey,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    'Detail',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  showVerificationDialog(
                                                _data.registrationForms![index]
                                                    .id
                                                    .toString(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(6),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Verifikasi',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showVerificationDialog(String id) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        height: 260,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/verification_image.png',
                height: 72,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        approve("permohonan", id);
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ColorPallete.mainColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            'Verifikasi',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              showRejectionDialog(id),
                        );
                        // Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            'Tolak',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              textStyle: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showRejectionDialog(String id) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        height: 260,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Masukkan alasan ditolak',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black26,
                  ),
                  fillColor: Colors.grey[300],
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 2,
                controller: _reason,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        reject("permohonan", id);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ColorPallete.mainColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            'Kembali',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              textStyle: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
