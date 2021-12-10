import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({Key? key}) : super(key: key);

  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white70),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/header_home.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white70,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              'assets/images/logo_1.png',
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Halo,  ',
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  textStyle: TextStyle(
                                    color: Colors.grey[700],
                                  )),
                            ),
                          ),
                          Text(
                            'Admin!',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Surat Pengajuan',
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Pilih Tahun',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: Colors.grey[600],
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom:100),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(10),
                          color: Colors.grey[100],
                          shadowColor: Colors.black,
                          child: Container(
                            height: 200,
                            child: Row(
                              children: [
                                Container(
                                  width: 185,
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Text(
                                          'ID: 99999999',
                                          style: GoogleFonts.roboto(
                                              fontSize: 10,
                                              textStyle: TextStyle(
                                                color: Colors.grey[500],
                                              )),
                                        ),
                                      ),
                                      Divider(
                                        indent: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 0),
                                        child: Text(
                                          'Nama Pemohon',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              textStyle: TextStyle(
                                                color: Colors.grey[500],
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 0),
                                        child: Text(
                                          'Doni Suraya',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textStyle: TextStyle(
                                                color: Colors.black54,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 30, 15, 0),
                                        child: Text(
                                          'Lampiran',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              textStyle: TextStyle(
                                                color: Colors.grey[500],
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 0),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.image,
                                                size: 20,
                                                color: Colors.orangeAccent,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 5),
                                                child: Text(
                                                  'Gambar bangunan.png',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12,
                                                      textStyle: TextStyle(
                                                        color: Colors
                                                            .grey[500],
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 0),
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    color:
                                                        Colors.greenAccent,
                                                    size: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                            .only(left: 5),
                                                    child: Text(
                                                      'Detail',
                                                      style: GoogleFonts
                                                          .roboto(
                                                              fontSize: 12,
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .greenAccent,
                                                              )),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete,
                                                      color:
                                                          Colors.redAccent,
                                                      size: 15,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                                  .only(
                                                              left: 5),
                                                      child: Text(
                                                        'Hapus',
                                                        style: GoogleFonts
                                                            .roboto(
                                                                fontSize:
                                                                    12,
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                )),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 155,
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Text(
                                          '20 September 2021, 09.41',
                                          style: GoogleFonts.roboto(
                                              fontSize: 10,
                                              textStyle: TextStyle(
                                                color: Colors.grey[500],
                                              )),
                                        ),
                                      ),
                                      Divider(
                                        endIndent: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 0),
                                        child: Text(
                                          'Status',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              textStyle: TextStyle(
                                                color: Colors.grey[500],
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 0),
                                        child: Text(
                                          'Disetujui',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textStyle: TextStyle(
                                                color: Colors.green,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 70, 15, 0),
                                        child: Container(
                                          height: 30,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 5),
                                                child: Icon(
                                                  Icons
                                                      .double_arrow_outlined,
                                                  color: Colors.white70,
                                                  size: 15,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 3),
                                                child: Text(
                                                  'Balas dengan surat',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 11,
                                                      textStyle: TextStyle(
                                                        color:
                                                            Colors.white70,
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, -1),
                                blurRadius: 8,
                              )
                            ],
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.document_scanner,
                                  color: Colors.blueAccent,
                                  textDirection: TextDirection.rtl,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Surat Masuk',
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      textStyle: TextStyle(
                                        color: Colors.grey[700],
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              '99',
                              style: GoogleFonts.roboto(
                                  fontSize: 41,
                                  fontWeight: FontWeight.bold,
                                  textStyle:
                                      TextStyle(color: Colors.redAccent)),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, -1),
                                  blurRadius: 8)
                            ],
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blueAccent,
                                  textDirection: TextDirection.rtl,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Surat Diproses',
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      textStyle: TextStyle(
                                        color: Colors.grey[700],
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              '99',
                              style: GoogleFonts.roboto(
                                  fontSize: 41,
                                  fontWeight: FontWeight.bold,
                                  textStyle:
                                      TextStyle(color: Colors.redAccent)),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
