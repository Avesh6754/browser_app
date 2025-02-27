import 'package:flutter/material.dart';
import 'package:flutter_adv_ch4/sevice/dbhelper.dart';

import 'package:flutter_adv_ch4/views/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dbhelper.dbhelper.database;

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
