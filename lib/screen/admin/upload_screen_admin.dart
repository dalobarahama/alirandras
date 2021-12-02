import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class UploadScreenAdmin extends StatefulWidget {
  const UploadScreenAdmin({Key? key}) : super(key: key);

  @override
  _UploadScreenAdminState createState() => _UploadScreenAdminState();
}

class _UploadScreenAdminState extends State<UploadScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Text(
                  'Unggah Dokumen',
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(
                        color: Colors.grey[700],
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Daun.png'),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                      ),
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text(
                            'Upload',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                textStyle: TextStyle(
                                  color: Colors.grey[500],
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                    itemCount: 1,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(10),
                        color: Colors.grey[100],
                        shadowColor: Colors.black,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(7)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.document_scanner,
                                size: 40,
                                color: Colors.blueAccent,
                              ),
                              Text(
                                'Dokumen 1.docx',
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    textStyle: TextStyle(
                                      color: Colors.grey[500],
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(7)),
                  child: Center(
                    child: Text(
                      'Proses',
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          textStyle: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
