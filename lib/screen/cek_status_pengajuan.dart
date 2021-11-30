import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/detail_card_statuspengajuan.dart';

class Cek_status_pengajuan extends StatefulWidget {
  const Cek_status_pengajuan({Key? key}) : super(key: key);

  @override
  _Cek_status_pengajuanState createState() => _Cek_status_pengajuanState();
}

class _Cek_status_pengajuanState extends State<Cek_status_pengajuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 27,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 95),
                    child: Container(
                      child: Text(
                        'Cek Status Pengajuan',
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
                padding: const EdgeInsets.only(right: 35, top: 53),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: ' Masukkan ID Pengajuan',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    suffixIcon: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Cek_status_pengajuan();
                        }));
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          'Cek Status',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(),
                child: ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(vertical: 50),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(10),
                      color: Colors.grey[200],
                      shadowColor: Colors.black,
                      child: Container(
                        height: 200,
                        child: Column(
                          children: [Text('abc')],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
