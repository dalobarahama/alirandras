import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/home_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Form_pendaftaran extends StatefulWidget {
  const Form_pendaftaran({Key? key}) : super(key: key);

  @override
  _Form_pendaftaranState createState() => _Form_pendaftaranState();
}

class _Form_pendaftaranState extends State<Form_pendaftaran> {
  @override
  String kec = '';
  String kel = '';
  String jenisPermohonan = '';
  List<String> kecamatan = [
    'Bungus Teluk Kabung',
    'Koto Tangah',
    'Kuranji',
    '	Lubuk Begalung',
    'Pauh'
  ];
  List<String> kelurahan = [
    'kel1',
    'kel1',
    'kel1',
    'kel1',
    'kel1',
    'kel1',
    'kel1',
  ];
  List<String> jenis_permohonan = [
    'Surat Informasi',
    'Surat Rekomendasi',
  ];
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
                        Navigator.pop(context,
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
              child: DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: jenis_permohonan,
                // label: "Pilih Jenis Permohonan",
                hint: "Pilih Jenis Permohonan",
                onChanged: (value) {
                  setState(() {
                    jenisPermohonan = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: kecamatan,
                // label: "Pilih Kecamatan",
                hint: "Pilih Kecamatan",
                onChanged: (value) {
                  setState(() {
                    kec = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: kelurahan,
                //   label: "Pilih Keluarahn",
                hint: "Pilih Kelurahan",
                onChanged: (value) {
                  setState(() {
                    kel = value!;
                  });
                },
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
