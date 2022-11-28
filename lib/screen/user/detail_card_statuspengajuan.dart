import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
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
                    child: const Text(
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
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
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
                            style: const TextStyle(color: Colors.grey),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Nama Pemohon',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.user!.name.toString(),
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Status dan Proses Pengajuan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.status.toString().toUpperCase(),
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(0),
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
                                                      ? const Icon(Icons.person,
                                                          color: Colors.green)
                                                      : const Icon(Icons.person,
                                                          color: Colors.grey),
                                                  const SizedBox(
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
                                                          style:
                                                              const TextStyle(
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
                              const Text(
                                'Alasan Ditolak',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _dataStatusPengajuan.reasonRejection ?? '-',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              )
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Jenis Permohonan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.type.toString(),
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Luas Bangunan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.buildingArea.toString(),
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Luas Lahan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.landArea.toString(),
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Lokasi Bangunan/Lahan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.buildingLocation.toString(),
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Peruntukan Bangunan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _dataStatusPengajuan.buildingDesignation.toString(),
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Gambar Dokumen / Lahan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _dataStatusPengajuan.registrationFormAttachments!.length > 0
                        ? Container(
                            child: ListView.builder(
                                itemCount: _dataStatusPengajuan
                                    .registrationFormAttachments!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(0),
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
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ));
                                }),
                          )
                        : const Text('-'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Lampiran Dokumen',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount: _dataStatusPengajuan
                              .registrationFormDocuments!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
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
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                  )),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Lokasi',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
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
                                  subdomains: const ['a', 'b', 'c'],
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
