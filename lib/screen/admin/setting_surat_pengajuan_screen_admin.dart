import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SettingSuratPengajuanScreenAdmin extends StatefulWidget {
  const SettingSuratPengajuanScreenAdmin({Key? key}) : super(key: key);

  @override
  _SettingSuratPengajuanScreenAdminState createState() =>
      _SettingSuratPengajuanScreenAdminState();
}

class _SettingSuratPengajuanScreenAdminState
    extends State<SettingSuratPengajuanScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Text(
                'Setting Surat Pengajuan',
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
