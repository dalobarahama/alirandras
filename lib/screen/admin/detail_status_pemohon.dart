import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/admin_pemohon_model.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusPemohonScreenAdmin extends StatefulWidget {
  //const StatusPengajuanScreenAdmin({Key? key}) : super(key: key);
  ApplicationLetter _dataPengajuan = ApplicationLetter();
  StatusPemohonScreenAdmin(this._dataPengajuan);

  @override
  _StatusPemohonScreenAdminState createState() =>
      _StatusPemohonScreenAdminState(this._dataPengajuan);
}

class _StatusPemohonScreenAdminState extends State<StatusPemohonScreenAdmin> {
  ApplicationLetter _dataPengajuan = ApplicationLetter();
  _StatusPemohonScreenAdminState(this._dataPengajuan);
  bool isMap = false;
  @override
  void initState() {
    double? lat = _dataPengajuan.lat;
    double? lng = _dataPengajuan.lng;
    point = LatLng(lat!, lng!);
    isMap = true;
    print(point);
    // TODO: implement initState
    super.initState();
  }

  LatLng point = LatLng(-1.240112, 116.873320);
  void _launchURL(String? url) async {
    if (!await launch(url!)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 50,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Container(
                  child: Text(
                    'Detail',
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        )),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM yy, HH:mm')
                              .format(_dataPengajuan.createdAt!),
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Nama Pemohon',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _dataPengajuan.user!.name!,
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Status dan Proses Pengajuan',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _dataPengajuan.status!.toUpperCase(),
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /* Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _dataPengajuan.mailRequest == null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(
                                          'Data Belum diverifikasi',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        )),
                                      )
                                    : ListView.builder(
                                        itemCount: _dataPengajuan.mailRequest!
                                            .mailPermissions!.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.all(0),
                                        itemBuilder:
                                            (BuildContext context, int index1) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _dataPengajuan
                                                            .mailRequest!
                                                            .mailPermissions![
                                                                index1]
                                                            .status ==
                                                        'diproses'
                                                    ? Icon(Icons.person,
                                                        color: Colors.green)
                                                    : Icon(Icons.person,
                                                        color: Colors.grey),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      _dataPengajuan
                                                                  .mailRequest!
                                                                  .mailPermissions![
                                                                      index1]
                                                                  .status!
                                                                  .toLowerCase() !=
                                                              'menunggu'
                                                          ? Text(DateFormat(
                                                                  'EEEE, dd MMMM yyyy',
                                                                  'id_ID')
                                                              .format(_dataPengajuan
                                                                  .mailRequest!
                                                                  .mailPermissions![
                                                                      index1]
                                                                  .updatedAt!))
                                                          : Container(),
                                                      Text(
                                                        'Surat telah ' +
                                                            _dataPengajuan
                                                                .mailRequest!
                                                                .mailPermissions![
                                                                    index1]
                                                                .status
                                                                .toString() +
                                                            ' oleh ' +
                                                            _dataPengajuan
                                                                .mailRequest!
                                                                .mailPermissions![
                                                                    index1]
                                                                .user!
                                                                .position
                                                                .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                          );
                                        },
                                      )),
                          ),*/
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Jenis Permohonan',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _dataPengajuan.type.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Luas Bangunan',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _dataPengajuan.buildingArea.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Luas Lahan',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _dataPengajuan.landArea.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Peruntukan Bangunan',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _dataPengajuan.buildingDesignation.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Lampiran',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            _dataPengajuan
                                        .registrationFormAttachments!.length ==
                                    0
                                ? const Text('-')
                                : Expanded(
                                    child: ListView.builder(
                                        itemCount: _dataPengajuan
                                            .registrationFormAttachments!
                                            .length,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        padding: const EdgeInsets.all(0),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            child: InkWell(
                                                onTap: () {
                                                  String _link =
                                                      'http://alirandras.inotive.id' +
                                                          _dataPengajuan
                                                              .registrationFormAttachments![
                                                                  index]
                                                              .file
                                                              .toString();
                                                  _launchURL(_link);
                                                },
                                                child: Text(
                                                  'Lampiran ' +
                                                      (index + 1).toString(),
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline),
                                                )),
                                          );
                                        }),
                                  )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Lampiran Dokumen',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            _dataPengajuan.registrationFormDocuments!.length ==
                                    0
                                ? const Text('-')
                                : Expanded(
                                    child: ListView.builder(
                                        itemCount: _dataPengajuan
                                            .registrationFormDocuments!.length,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        padding: const EdgeInsets.all(0),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            child: InkWell(
                                                onTap: () {
                                                  String _link =
                                                      'https://alirandras.inotive.id' +
                                                          _dataPengajuan
                                                              .registrationFormDocuments![
                                                                  index]
                                                              .document
                                                              .toString();
                                                  _launchURL(_link);
                                                },
                                                child: Text(
                                                  'Lampiran Dokumen ' +
                                                      (index + 1).toString(),
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline),
                                                )),
                                          );
                                        }),
                                  )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Alamat Lengkap',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _dataPengajuan.buildingLocation.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Peta Lokasi',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: 230,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: isMap == false
                              ? const Center(child: CircularProgressIndicator())
                              : FlutterMap(
                                  options: MapOptions(
                                    center: point,
                                    zoom: 18.0,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: ['a', 'b', 'c'],
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          width: 100,
                                          height: 100,
                                          point: point,
                                          builder: (ctx) => Container(
                                            child: const Image(
                                              image: AssetImage(
                                                  'assets/images/Vector.png'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
