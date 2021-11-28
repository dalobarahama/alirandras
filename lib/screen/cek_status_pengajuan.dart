import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/detail_card_statuspengajuan.dart';

class Cek_status_pengajuan extends StatefulWidget {
  const Cek_status_pengajuan({Key? key}) : super(key: key);

  @override
  _Cek_status_pengajuanState createState() => _Cek_status_pengajuanState();
}

class _Cek_status_pengajuanState extends State<Cek_status_pengajuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 27,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 95),
                    child: Container(
                      child: Text(
                        'Cek Status Pengajuan',
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35, top: 53),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: ' Masukkan ID Pengajuan',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    suffixIcon: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Cek_status_pengajuan();
                        }));
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          'Cek Status',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35, top: 40),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ID 98875666',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '22 September 2021, 08.15',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Pengguna',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Status',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yulia Purnama',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'Diproses',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lapiran',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Gambar bangunan.png',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Icon(
                              Icons.visibility,
                              color: Colors.green,
                              size: 15,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Detail_card_statuspengajuan();
                                }));
                              },
                              child: Text(
                                'Detail',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 15,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              'Hapus',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35, top: 40),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ID 98875666',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '22 September 2021, 08.15',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Pengguna',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Status',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yulia Purnama',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'Ditolak',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Alasan ditolak',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lapiran',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Kurang memenuhi kualifikasi',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Gambar bangunan.png',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Icon(
                              Icons.visibility,
                              color: Colors.green,
                              size: 15,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Detail_card_statuspengajuan();
                                }));
                              },
                              child: Text(
                                'Detail',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 15,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              'Hapus',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
