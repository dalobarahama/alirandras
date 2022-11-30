import 'dart:io';

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

  List<String>? _dokumenFileList = <String>[];

  bool isMap = false;

  @override
  void initState() {
    for (var item in _dataStatusPengajuan.registrationFormAttachments!) {
      _dokumenFileList!.add(item.file!);
    }
    for (var item in _dataStatusPengajuan.registrationFormDocuments!) {
      _dokumenFileList!.add(item.document!);
    }
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
                height: 12,
              ),
              _dataStatusPengajuan.mailRequest != null
                  ? _dataStatusPengajuan.mailRequest!.mailPermissions != null
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.separated(
                              itemCount: _dataStatusPengajuan
                                  .mailRequest!.mailPermissions!.length,
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                thickness: 1,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index1) {
                                return _dataStatusPengajuan.mailRequest!
                                            .mailPermissions![index1] !=
                                        null
                                    ? Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            _dataStatusPengajuan
                                                        .mailRequest!
                                                        .mailPermissions![
                                                            index1]
                                                        .status
                                                        .toString()
                                                        .toLowerCase() !=
                                                    'menunggu'
                                                ? const ImageIcon(
                                                    AssetImage(
                                                        'assets/icons/icon_user_permission.png'),
                                                    color: Colors.green)
                                                : const ImageIcon(
                                                    AssetImage(
                                                        'assets/icons/icon_user_permission.png'),
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
                                                        color: Colors.black54),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ),
                        )
                      : Container()
                  : Container(),
              const SizedBox(
                height: 24,
              ),
              _dataStatusPengajuan.status!.toString() == 'ditolak'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alasan Ditolak',
                          style: TextStyle(
                            color: ColorPallete.mainColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _dataStatusPengajuan.reasonRejection ?? '-',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  : Container(),
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
              const Text(
                'FIle terlampir',
                style: TextStyle(
                  color: ColorPallete.mainColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                children: [
                  ..._dokumenFileList!.map((file) {
                    return Container(
                      margin: const EdgeInsets.only(
                        top: 6,
                      ),
                      padding: const EdgeInsets.only(
                        top: 14,
                        bottom: 14,
                        left: 17,
                        right: 17,
                      ),
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: InkWell(
                        onTap: () {
                          String link = 'https://alirandras.inotive.id$file';
                          _launchURL(link);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: file.split('.').last != 'pdf'
                                      ? Image.file(File(file))
                                      : Image.asset(
                                          'assets/images/pdf_icon.png'),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    file.split('/').last,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
