// ignore_for_file: prefer_const_constructors

import 'package:bbc/cadaster.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => IndexState();
}

class IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logobbc.png',
          width: 50,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Cadaster())));
              },
              icon: Icon(Icons.person))
        ],
        backgroundColor: Color.fromARGB(255, 24, 24, 26),
      ),
    );
  }
}
