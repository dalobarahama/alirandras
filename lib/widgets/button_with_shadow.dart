import 'package:flutter/material.dart';

import '../main.dart';

Widget buttonWithShadow(String text, Color background,bool isLoading) {
  return Container(
    width: double.infinity,
    height: 60,
    margin: EdgeInsets.symmetric(horizontal: 30),
    child: Center(
      child: 
      isLoading?
      Container(
        height: 20,
        width:20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
        ),
      ):
      Text(
        text,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ),
    decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: background.withOpacity(0.4),
              offset: Offset(0, 10),
              blurRadius: 20)
        ]),
  );
}
