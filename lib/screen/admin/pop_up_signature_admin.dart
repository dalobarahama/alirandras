import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class PopUpSignature extends StatefulWidget {
  const PopUpSignature({Key? key}) : super(key: key);

  @override
  _PopUpSignatureState createState() => _PopUpSignatureState();
}

class _PopUpSignatureState extends State<PopUpSignature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 20),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Daun.png'),
                        fit: BoxFit.cover)),
              ),
            ),
            Container(
              child: Text(
                'Setuju dan tandatangi file?',
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    textStyle: TextStyle(
                      color: Colors.grey[700],
                    )),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Setuju',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            textStyle: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.clear,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Tolak',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            textStyle: TextStyle(
                              color: Colors.black54,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
