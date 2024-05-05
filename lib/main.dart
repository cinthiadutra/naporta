import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naporta/view/home_page.dart';

void main() {
  runApp(const NaPortaApp());
}

class NaPortaApp extends StatelessWidget {
  const NaPortaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomePage(),
    );
  }
}
