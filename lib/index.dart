// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bbc/acervo.dart';
import 'package:bbc/alocation.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/help.dart';
import 'package:bbc/perfil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => IndexState();
}

class IndexState extends State<Index> {

  String? savedName;
  String? savedId;

  Future<void> _loadSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('name');
      savedId = prefs.getString('id');
    });
  }
  @override
  Widget build(BuildContext context) {
    _loadSessionData();
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logobbc.png',
          width: 50,
        ),
        actions: [
          IconButton(
              onPressed: () {
                if(savedId == null || savedName == null){
                  Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Cadaster())));
                }else{
                  Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Perfil())));
                }
              },
              icon: Icon(Icons.person))
        ],
        backgroundColor: Color.fromARGB(255, 24, 24, 26),
      ),

      body: 
      SingleChildScrollView( child: 
        Column(
        children: [
          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple,
                    Colors.blue,
                  ],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/celular.png.png' , width: 200,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Bibliocamp", style: TextStyle(color: Colors.white , fontSize: 30, fontWeight: FontWeight.bold),),
                              Text("A melhor maneira", style: TextStyle(color: Colors.white , fontSize: 18),),
                              Text("de gerenciar seus", style: TextStyle(color: Colors.white , fontSize: 18),),
                              Text("livros emprestados", style: TextStyle(color: Colors.white , fontSize: 18),),
                              Text("da escola!", style: TextStyle(color: Colors.white , fontSize: 18),),
                              
                            ],
                          ),
                        ],
                      )


                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 24, 24, 26),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/Pessoasx.png', width: 200,)
                         ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/Alunosx.png', width: 200,)
                         ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/LivrosX.png', width: 200,)
                        ],
                      ),

                      ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue,
                    Colors.purple,
                  ],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/diversidadedelivros.png', width: 200,)
                         ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/maisacesso.png', width: 200,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 24, 24, 26),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(onPressed: () {
          }, icon: Icon(Icons.info, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            if(savedName == null || savedId == null){

            }else{
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Acervo())));
            }
          }, icon: Icon(Icons.book,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            if(savedId == null || savedName == null){

            }else{
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Alocation())));
            }
          }, icon: Icon(Icons.inbox_outlined,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Help())));
          }, icon: Icon(Icons.question_mark_rounded,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            if(savedId == null || savedName == null){

            }else{
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Perfil())));
            }
          }, icon: Icon(Icons.person_outlined,color: Colors.white, size: 40,)),
        ],),
      ),
    );
  }
}
