import 'package:flutter/material.dart';
import 'package:untitled56/Login/Registre.dart';

import 'Login/Login.dart';
import 'Login/Sign_in.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email =TextEditingController();
    TextEditingController password =TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
