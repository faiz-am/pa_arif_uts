import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const NailCareApp());
}

class NailCareApp extends StatelessWidget {
  const NailCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Kecantikan Kuku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const HomePage(), // langsung ke HomePage
    );
  }
}
