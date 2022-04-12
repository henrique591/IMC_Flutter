import 'package:flutter/material.dart';
import 'package:imc_app/home.dart';

void main() {
  runApp(const MyAppImc());
}

class MyAppImc extends StatelessWidget {
  const MyAppImc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
