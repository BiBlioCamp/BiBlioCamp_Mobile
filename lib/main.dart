// ignore_for_file: prefer_const_constructors

import 'package:bbc/cadaster.dart';
import 'package:bbc/contact.dart';
import 'package:bbc/index.dart';
import 'package:bbc/login.dart';
import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: Login(),
      routes: {
        '/': (context) => Index(),
        '/cadastro': (context) => Cadaster(),
        '/login': (context) => Login(),
        '/contato': (context) => Contact(),
      },
    );
  }
}
