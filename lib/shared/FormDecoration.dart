import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    hintText: 'মোবাইল নাম্বার',
    fillColor: Colors.white60,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
          width: 2.0,
        )),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2.0,
        )),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2.0,
      ),
    ));