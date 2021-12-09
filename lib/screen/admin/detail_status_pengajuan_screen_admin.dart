import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class StatusPengajuanScreenAdmin extends StatefulWidget {
  const StatusPengajuanScreenAdmin({Key? key}) : super(key: key);

  @override
  _StatusPengajuanScreenAdminState createState() =>
      _StatusPengajuanScreenAdminState();
}

class _StatusPengajuanScreenAdminState
    extends State<StatusPengajuanScreenAdmin> {
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
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                  child: Container(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
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
                            '22 September 2021, 10.11',
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                textStyle: TextStyle(
                                  color: Colors.grey[500],
                                )),
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Yuli Purnama',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                )),
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Diproses',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                textStyle: TextStyle(
                                  color: Colors.grey[600],
                                )),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 20,
                                            color: Colors.green,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              'Surat sudah diverivikasi oleh Sekretaris',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  textStyle: TextStyle(
                                                    color: Colors.grey[500],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 20,
                                            color: Colors.green,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              'Surat sudah diverivikasi oleh Kabid SDA',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  textStyle: TextStyle(
                                                    color: Colors.grey[500],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 20,
                                            color: Colors.grey[500],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              'Surat sudah diverivikasi oleh Kabid Renwa SDA',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  textStyle: TextStyle(
                                                    color: Colors.grey[500],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Surat Informasi',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '4X2 Meter',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '4X2 Meter',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(Icons.image, color: Colors.orange),
                              Text(
                                'Gambar Bangunan.png',
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    textStyle: TextStyle(
                                      color: Colors.grey[700],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Jl. MT Haryono',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(color: Colors.grey),
                          ),
                          SizedBox(
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
        ));
  }
}
