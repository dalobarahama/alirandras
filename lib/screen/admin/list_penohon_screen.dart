import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPemohonScreen extends StatefulWidget {
  const ListPemohonScreen({Key? key}) : super(key: key);

  @override
  _ListPemohonScreenState createState() => _ListPemohonScreenState();
}

class _ListPemohonScreenState extends State<ListPemohonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                'List Permohonan',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom:20),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(10),
                      color: Colors.grey[100],
                      shadowColor: Colors.black,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ID: 99999999',
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      textStyle: TextStyle(
                                        color: Colors.grey[500],
                                      )),
                                ),
                                Text(
                                  '20 September 2021, 09.41',
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      textStyle: TextStyle(
                                        color: Colors.grey[500],
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nama Pemohon',
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          textStyle: TextStyle(
                                            color: Colors.grey[500],
                                          )),
                                    ),
                                    Text(
                                      'Doni Suraya',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          textStyle: TextStyle(
                                            color: Colors.black54,
                                          )),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          'Verifikasi',
                                          style: GoogleFonts.roboto(
                                              fontSize: 11,
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
