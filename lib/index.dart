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
        
        actions: [
          IconButton(onPressed: () {
            Center();
            Navigator.push(context, MaterialPageRoute(builder: ((context) => Cadaster())));
          }, icon: Icon(Icons.person))
          ],
       centerTitle: true,
        backgroundColor: Color.fromARGB(255, 24, 24, 26),
         ),
    );
  }
}