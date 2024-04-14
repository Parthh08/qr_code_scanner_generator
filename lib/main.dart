import 'package:flutter/material.dart';
import 'package:scanner_generator/output.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_generator/qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QRGenerator(),
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,

        ),
        useMaterial3: true,
      ),
    );
  }
}


