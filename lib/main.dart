
import 'package:flutter/material.dart';

import 'dialog_pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyHomePage(),
      home: DialogToPdfPage(),
    );
  }
}
