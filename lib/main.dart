import 'package:flutter/material.dart';
import 'MainPage/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Code Land",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white70)),
    );
  }
}
