import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/utils/color_pallete.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.mainBackgroundColor,
        title: const Text(
          "Detail Pengajuan",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: ColorPallete.mainBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Jenis Permohonan',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                _dataStatusPengajuan.type.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Status Pengajuan',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                _dataStatusPengajuan.status.toString().toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Kecamatan',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                _dataStatusPengajuan.district.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Kelurahan',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                _dataStatusPengajuan.subdistrict.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Luas Bangunan',
                        style: TextStyle(
                          color: ColorPallete.mainColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "${_dataStatusPengajuan.buildingArea.toString()} m",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 72,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Luas Lahan',
                        style: TextStyle(
                          color: ColorPallete.mainColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "${_dataStatusPengajuan.landArea.toString()} m",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Lokasi Bangunan',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                _dataStatusPengajuan.buildingLocation.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Map',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
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
                                    image:
                                        AssetImage('assets/images/Vector.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              const SizedBox(
                height: 24,
              ),
              _dataStatusPengajuan.mailRequest != null
                  ? _dataStatusPengajuan.mailRequest!.mailPermissions != null
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
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index1) {
                                return _dataStatusPengajuan.mailRequest!
                                            .mailPermissions![index1] !=
                                        null
                                    ? Padding(
                                        padding: const EdgeInsets.all(15.0),
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _dataStatusPengajuan
                                                                .mailRequest!
                                                                .mailPermissions![
                                                                    index1]
                                                                .status!
                                                                .toLowerCase() !=
                                                            'menunggu'
                                                        ? Text(
                                                            DateFormat(
                                                                    'EEEE, dd MMMM yy',
                                                                    'id_ID')
                                                                .format(_dataStatusPengajuan
                                                                    .mailRequest!
                                                                    .mailPermissions![
                                                                        index1]
                                                                    .updatedAt!),
                                                          )
                                                        : Container(),
                                                    Text(
                                                      'Surat telah diverifikasi oleh ${_dataStatusPengajuan.mailRequest!.mailPermissions![index1].user!.position}',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
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
                          style: TextStyle(color: Colors.grey, fontSize: 12),
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
              const Text(
                'Gambar Dokumen / Lahan',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
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
                                  'https://alirandras.inotive.id${_dataStatusPengajuan.registrationFormAttachments![index].file}';
                              _launchURL(_link);
                            },
                            child: Text(
                              'Lampiran${index + 1}',
                              style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          );
                        },
                      ),
                    )
                  : const Text('-'),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Lampiran Dokumen',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                itemCount:
                    _dataStatusPengajuan.registrationFormDocuments!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      String _link =
                          'http://alirandras.inotive.id${_dataStatusPengajuan.registrationFormDocuments![index].document}';
                      _launchURL(_link);
                    },
                    child: Text(
                      'Lampiran${index + 1}',
                      style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
