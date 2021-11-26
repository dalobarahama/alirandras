// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var overvlow;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 90,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.menu,
                          color: Colors.blue[900],
                          size: 30,
                        )),
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.blue[900],
                          size: 30,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Hello, Suryanto',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[700],
                          fontSize: 20),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(45)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1634901623176-14daf9946560?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=693&q=80',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(overflow: Overflow.visible, children: [
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.lightBlue[200],
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: [
                          Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 20, 20)),
                          Text(
                            'Selamat Datang, di ',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            'ALIRANDRAS ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 47,
                        ),
                        child: Text('Aplikasi layanan informasi/rekomendasi',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 192),
                        child: Text('drainase ekspress',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  height: 170,
                  width: 360,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, right: 210),
                        child: Container(
                          child: Text(
                            'Alur Proses',
                            style: TextStyle(
                                fontSize: 20, color: Colors.lightBlue),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.send_sharp,
                                color: Colors.lightBlue,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '1. Pengajuan',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                              Text(
                                '   ',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.list,
                                color: Colors.lightBlue,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '2. Isi formulir',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                              Text(
                                '   ',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.lock_clock,
                                color: Colors.lightBlue,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '3. Menunggu',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                              Text(
                                'pemberitahuan',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.done,
                                color: Colors.lightBlue,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '4. Selalu cek',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                              Text(
                                'pemberitahuan',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.nature_people_rounded,
                                color: Colors.lightBlue,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '5. Disetujui',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                              Text(
                                'dan selesai',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                bottom: -110,
                left: 20,
                right: 20,
              ),
            ]),
            SizedBox(
              height: 120,
            ),
            Container(
              height: 200,
              width: 360,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(top: 90, left: 110),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Isi Formulir Pengajuan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Klik untuk ajukan formulir pengajuan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 140, top: 10),
                        child: Container(
                          child: Icon(
                            Icons.arrow_right_alt_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
