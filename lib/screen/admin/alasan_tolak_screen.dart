import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AlasanTolakScreen extends StatefulWidget {
  const AlasanTolakScreen({Key? key}) : super(key: key);

  @override
  _AlasanTolakScreenState createState() => _AlasanTolakScreenState();
}

class _AlasanTolakScreenState extends State<AlasanTolakScreen> {
  TextEditingController _alasanTolakController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(7)),
              width: double.infinity,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 25,
                  decoration: InputDecoration(
                      hintText: 'Ketik alasan ditolak...',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black26)),
                  controller: _alasanTolakController,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(0, 2),
                  blurRadius: 5,
                )
              ], color: Colors.green, borderRadius: BorderRadius.circular(7)),
              child: Center(
                child: Text(
                  'Submit',
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      textStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey)),
              child: Center(
                child: Text(
                  'Kembali',
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      textStyle: TextStyle(
                        color: Colors.black54,
                      )),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
