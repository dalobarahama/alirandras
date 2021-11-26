import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home_screen.dart';
import 'Log_in.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: 150,
                child: Image.asset(
                  'image/Daun.png',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 46,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33),
            child: Row(
              children: [
                Text(
                  'Nama',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 33, right: 32, top: 15, bottom: 18),
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                  hintText: 'Your Name',
                  border: InputBorder.none,
                )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33),
            child: Row(
              children: [
                Text(
                  'Email',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 33, right: 32, top: 15, bottom: 15),
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                  hintText: 'Your Email',
                  border: InputBorder.none,
                )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33),
            child: Row(
              children: [
                Text(
                  'Password',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 33, right: 32, top: 18, bottom: 33),
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33, right: 32, bottom: 30),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Log_in();
                }));
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 119,
                ),
                child: Text(
                  'Sudah punya akun?',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Log_in();
                  }));
                },
                child: Text(
                  ' Login',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
