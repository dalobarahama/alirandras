import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/screen/user/cek_status_pengajuan.dart';
import 'package:flutter_application_3/screen/user/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';

class Detail_card_statuspengajuan extends StatefulWidget {
  RegistrationForm1 _dataStatusPengajuan = RegistrationForm1();
  Detail_card_statuspengajuan(this._dataStatusPengajuan);

  @override
  _Detail_card_statuspengajuanState createState() =>
      _Detail_card_statuspengajuanState(this._dataStatusPengajuan);
}

class _Detail_card_statuspengajuanState
    extends State<Detail_card_statuspengajuan> {
  RegistrationForm1 _dataStatusPengajuan = RegistrationForm1();
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
              padding: const EdgeInsets.only(top: 50, left: 35),
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
                  padding: const EdgeInsets.only(left: 27, top: 25),
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
                            _dataStatusPengajuan.createdAt.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[200],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Nama Pemohon',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _dataStatusPengajuan.user!.name.toString(),
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Text(
                            'Status dan Proses Pengajuan',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _dataStatusPengajuan.status.toString(),
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, left: 20),
                        child: _dataStatusPengajuan.mailRequest == null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  'Data Belum diverifikasi',
                                  style: TextStyle(color: Colors.black54),
                                )),
                              )
                            : ListView.builder(
                                itemCount: _dataStatusPengajuan
                                    .mailRequest!.mailPermissions!.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                itemBuilder:
                                    (BuildContext context, int index1) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        child: Row(
                                      children: [
                                        _dataStatusPengajuan
                                                    .mailRequest!
                                                    .mailPermissions![index1]
                                                    .status ==
                                                'diproses'
                                            ? Icon(Icons.person,
                                                color: Colors.green)
                                            : Icon(Icons.person,
                                                color: Colors.grey),
                                        Text(
                                          'Surat telah diverifikasi oleh ' +
                                              _dataStatusPengajuan
                                                  .mailRequest!
                                                  .mailPermissions![index1]
                                                  .user!
                                                  .name
                                                  .toString(),
                                          style:
                                              TextStyle(color: Colors.black54),
                                        )
                                      ],
                                    )),
                                  );
                                },
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            'Jenis Permohonan',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _dataStatusPengajuan.type.toString(),
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            'Luas Bangunan',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _dataStatusPengajuan.buildingArea.toString(),
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            'Luas Lahan',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _dataStatusPengajuan.landArea.toString(),
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            'Lokasi Bangunan',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _dataStatusPengajuan.buildingLocation.toString(),
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            'Lampiran',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: _dataStatusPengajuan
                                  .registrationFormAttachments!.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: InkWell(
                                      onTap: () {
                                        String _link =
                                            'http://alirandras.inotive.id' +
                                                _dataStatusPengajuan
                                                    .registrationFormAttachments![
                                                        index]
                                                    .file
                                                    .toString();
                                        _launchURL(_link);
                                      },
                                      child: Text(
                                        'Lampiran $index',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      )),
                                );
                              }),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            'Lokasi',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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
