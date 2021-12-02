import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopUpDoneScreen extends StatefulWidget {
  const PopUpDoneScreen({Key? key}) : super(key: key);

  @override
  _PopUpDoneScreenState createState() => _PopUpDoneScreenState();
}

class _PopUpDoneScreenState extends State<PopUpDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 100,
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
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  child: Text(
                    'Surat Terkirim!',
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        textStyle: TextStyle(
                          color: Colors.black54,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 80, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(0, 2),
                          blurRadius: 5,
                        )
                      ],
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(7)),
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
                          'Kembali',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
