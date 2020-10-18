import 'package:flutter/material.dart';
import 'package:user_panel/pages/LogInPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'দ্বীপ ক্যাবল ভিশন',
      theme: ThemeData(
        primarySwatch: Colors.green,
        canvasColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LogIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}

