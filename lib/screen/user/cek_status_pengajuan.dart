import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/user/detail_card_statuspengajuan.dart';
import 'package:google_fonts/google_fonts.dart';

class Cek_status_pengajuan extends StatefulWidget {
  const Cek_status_pengajuan({Key? key}) : super(key: key);

  @override
  _Cek_status_pengajuanState createState() => _Cek_status_pengajuanState();
}

class _Cek_status_pengajuanState extends State<Cek_status_pengajuan> {
  List namapengguna = [
    'Andre',
    'Faiq',
    'Alun',
    'Rafi',
    'Azmi',
    'Ipan',
    'Cacan',
    'Rc',
    'Rio',
    'Roni'
  ];
  List idpengguna = [
    '00001',
    '00002',
    '00003',
    '00004',
    '00005',
    '00006',
    '00007',
    '00008',
    '00009',
    '00010',
  ];

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
                padding: const EdgeInsets.only(right: 25),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(),
                  child: ListView.builder(
                    itemCount: this.namapengguna.length,
                    padding: EdgeInsets.symmetric(
                      vertical: 50,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(10),
                        color: Colors.grey[200],
                        shadowColor: Colors.black,
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ID :',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          textStyle: TextStyle(
                                            color: Colors.grey[500],
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 50),
                                      child: Text(
                                        idpengguna[index],
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                              color: Colors.grey[500],
                                            )),
                                      ),
                                    ),
                                    Text(
                                      '20 November 2021, 14.20',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          textStyle: TextStyle(
                                            color: Colors.grey[500],
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 10, top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Nama Pengguna',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                              color: Colors.grey[500],
                                            )),
                                      ),
                                      Text(
                                        'Status',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                              color: Colors.grey[500],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 10, top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        namapengguna[index],
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                              color: Colors.grey[700],
                                            )),
                                      ),
                                      Text(
                                        'Diproses',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                              color: Colors.grey[700],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 10, top: 40),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Lampiran',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                              color: Colors.grey[500],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 10, top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Gambar bangunan.png',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                              color: Colors.grey[700],
                                            )),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Icon(
                                        Icons.visibility,
                                        color: Colors.green,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Detail',
                                        style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            textStyle: TextStyle(
                                              color: Colors.green,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Hapus',
                                        style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            textStyle: TextStyle(
                                              color: Colors.red,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
