import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/screen/user/cek_status_pengajuan.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';

class Detail_card_statuspengajuan extends StatefulWidget {
  ApplicationLetter1 _dataStatusPengajuan = ApplicationLetter1();
  Detail_card_statuspengajuan(this._dataStatusPengajuan);

  @override
  _Detail_card_statuspengajuanState createState() =>
      _Detail_card_statuspengajuanState(this._dataStatusPengajuan);
}

class _Detail_card_statuspengajuanState
    extends State<Detail_card_statuspengajuan> {
  ApplicationLetter1 _dataStatusPengajuan = ApplicationLetter1();
  _Detail_card_statuspengajuanState(this._dataStatusPengajuan);
  @override
  bool isMap = false;
  void initState() {
    setState(() {
      double? lat = _dataStatusPengajuan.lat;
      double? lng = _dataStatusPengajuan.lng;
      point = LatLng(lat!, lng!);
      isMap = true;
      print(point);
    });
    super.initState();
  }

  LatLng point = LatLng(-1.240112, 116.873320);

  void _launchURL(String? url) async {
    if (!await launch(url!)) throw 'Could not launch $url';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 27),
              child: Row(
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.lightBlue[300],
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27, top: 15),
                  child: Container(
                    child: Text(
                      'Detail',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ID: ' + _dataStatusPengajuan.id.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            DateFormat('dd MMMM yy, HH:mm')
                                .format(_dataStatusPengajuan.createdAt!),
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                textStyle: TextStyle(
                                  color: Colors.grey[500],
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[200],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nama Pemohon',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.user!.name.toString(),
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Status dan Proses Pengajuan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.status.toString().toUpperCase(),
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _dataStatusPengajuan.mailRequest != null
                        ? _dataStatusPengajuan.mailRequest!.mailPermissions !=
                                null
                            ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView.builder(
                                    itemCount: _dataStatusPengajuan
                                        .mailRequest!.mailPermissions!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(0),
                                    itemBuilder:
                                        (BuildContext context, int index1) {
                                      return _dataStatusPengajuan.mailRequest!
                                                  .mailPermissions![index1] !=
                                              null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Container(
                                                  child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _dataStatusPengajuan
                                                              .mailRequest!
                                                              .mailPermissions![
                                                                  index1]
                                                              .status
                                                              .toString()
                                                              .toLowerCase() !=
                                                          'menunggu'
                                                      ? Icon(Icons.person,
                                                          color: Colors.green)
                                                      : Icon(Icons.person,
                                                          color: Colors.grey),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        _dataStatusPengajuan
                                                                    .mailRequest!
                                                                    .mailPermissions![
                                                                        index1]
                                                                    .status!
                                                                    .toLowerCase() !=
                                                                'menunggu'
                                                            ? Text(DateFormat(
                                                                    'EEEE, dd MMMM yy',
                                                                    'id_ID')
                                                                .format(_dataStatusPengajuan
                                                                    .mailRequest!
                                                                    .mailPermissions![
                                                                        index1]
                                                                    .updatedAt!))
                                                            : Container(),
                                                        Text(
                                                          'Surat telah diverifikasi oleh ' +
                                                              _dataStatusPengajuan
                                                                  .mailRequest!
                                                                  .mailPermissions![
                                                                      index1]
                                                                  .user!
                                                                  .position
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                            )
                                          : Container();
                                    },
                                  ),
                                ),
                              )
                            : Container()
                        : Container(),
                    _dataStatusPengajuan.status!.toString() == 'ditolak'
                        ? Column(
                            children: [
                              Text(
                                'Alasan Ditolak',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              SizedBox(height: 5),
                              Text(
                                _dataStatusPengajuan.reasonRejection ?? '-',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              )
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Jenis Permohonan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.type.toString(),
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Luas Bangunan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.buildingArea.toString(),
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Luas Lahan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.landArea.toString(),
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Lokasi Bangunan/Lahan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.buildingLocation.toString(),
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Peruntukan Bangunan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.buildingDesignation.toString(),
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Gambar Dokumen / Lahan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _dataStatusPengajuan.registrationFormAttachments!.length > 0
                        ? Container(
                            child: ListView.builder(
                                itemCount: _dataStatusPengajuan
                                    .registrationFormAttachments!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () {
                                        String _link =
                                            'https://alirandras.inotive.id' +
                                                _dataStatusPengajuan
                                                    .registrationFormAttachments![
                                                        index]
                                                    .file
                                                    .toString();
                                        _launchURL(_link);
                                      },
                                      child: Text(
                                        'Lampiran' + (index + 1).toString(),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ));
                                }),
                          )
                        : Text('-'),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Lampiran Dokumen',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount: _dataStatusPengajuan
                              .registrationFormDocuments!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: InkWell(
                                  onTap: () {
                                    String _link =
                                        'http://alirandras.inotive.id' +
                                            _dataStatusPengajuan
                                                .registrationFormDocuments![
                                                    index]
                                                .document
                                                .toString();
                                    _launchURL(_link);
                                  },
                                  child: Text(
                                    'Lampiran' + (index + 1).toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                  )),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Lokasi',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      height: 230,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: isMap == false
                          ? Center(child: CircularProgressIndicator())
                          : FlutterMap(
                              options: MapOptions(
                                center: point,
                                zoom: 18.0,
                              ),
                              layers: [
                                TileLayerOptions(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c'],
                                ),
                                MarkerLayerOptions(markers: [
                                  Marker(
                                      width: 100,
                                      height: 100,
                                      point: point,
                                      builder: (ctx) => Container(
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/Vector.png'),
                                            ),
                                          ))
                                ])
                              ],
                            ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
