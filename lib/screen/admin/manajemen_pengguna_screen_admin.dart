import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ManajemenPenggunaScreenAdmin extends StatefulWidget {
  const ManajemenPenggunaScreenAdmin({Key? key}) : super(key: key);

  @override
  _ManajemenPenggunaScreenAdminState createState() =>
      _ManajemenPenggunaScreenAdminState();
}

class _ManajemenPenggunaScreenAdminState
    extends State<ManajemenPenggunaScreenAdmin> {
  TextEditingController _searchListController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Container(
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
                  height: 20,
                ),
                Text(
                  'Manajemen Pengguna',
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    controller: _searchListController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 500,
                  child: ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(10),
                        color: Colors.grey[100],
                        shadowColor: Colors.black,
                        child: Container(
                          height: 100,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(65)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(65),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Suryanto',
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        textStyle: TextStyle(
                                          color: Colors.grey,
                                        )),
                                  ),
                                  Text(
                                    'Admin',
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        textStyle: TextStyle(
                                          color: Colors.blue,
                                        )),
                                  ),
                                  Text(
                                    'Suryanto.admin@mail.com',
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        textStyle: TextStyle(
                                          color: Colors.grey,
                                        )),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  child: Icon(Icons.assessment),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}
