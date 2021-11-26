import 'package:flutter/material.dart';

class Log_in extends StatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  _Log_inState createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                'Log In',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
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
          padding: const EdgeInsets.all(30.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                hintText: 'Your Email',
              )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
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
          padding: const EdgeInsets.all(30.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                hintText: 'Password',
              )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'Log In',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 97),
              child: Text(
                'Lupa password?',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Text(
              ' Reset Password',
              style: TextStyle(color: Colors.red),
            ),
          ],
        )
      ],
    ));
  }
}
