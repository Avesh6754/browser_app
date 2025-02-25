import 'package:flutter/material.dart';
import 'package:flutter_adv_ch4/controller/homeController.dart';
import 'package:flutter_adv_ch4/views/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: false,
      home: HomePage(),
    );
  }
}
