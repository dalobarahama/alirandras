import 'package:flutter/material.dart';
import 'package:flutter_application_3/main.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.amberAccent),
        child: SingleChildScrollView(
          child: Container(
            width: 200,
            height: 200,
            child: ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: [Text('abc')],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
