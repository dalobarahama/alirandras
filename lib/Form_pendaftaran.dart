import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home_screen.dart';

class Form_pendaftaran extends StatefulWidget {
  const Form_pendaftaran({Key? key}) : super(key: key);

  @override
  _Form_pendaftaranState createState() => _Form_pendaftaranState();
}

class _Form_pendaftaranState extends State<Form_pendaftaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 49, left: 35),
              child: Row(
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Home();
                        }));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.lightBlue[300],
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27, top: 25),
                  child: Container(
                    child: Text(
                      'Isi Formulir Pendaftaran',
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
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: 230,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: TextField(
                decoration: InputDecoration(
                  icon: Text(
                    'Jenis Permohonan',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: ' Pilih jenis permohonan',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: TextField(
                decoration: InputDecoration(
                  icon: Text(
                    'Kecamatan             ',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: ' Pilih Kecamatan',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: TextField(
                decoration: InputDecoration(
                  icon: Text(
                    'Kelurahan               ',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: ' Pilih Kelurahan',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: TextField(
                decoration: InputDecoration(
                  icon: Text(
                    'Luas Bangunan     ',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: TextField(
                decoration: InputDecoration(
                  icon: Text(
                    'Luas Lahan            ',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: TextField(
                decoration: InputDecoration(
                  icon: Text(
                    'Lokasi Bangunan  ',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: TextField(
                decoration: InputDecoration(
                  icon: Text(
                    'Alamat Lengkap    ',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Gambar Bangunan',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    height: 60,
                    width: 214,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: Text(
                      'Upload File',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      body: Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40, right: 40, top: 200),
                                child: Container(
                                  color: Colors.amber,
                                  height: 200,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                child: Center(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ),
                                ),
                                top: 170,
                                left: 150,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }));
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
