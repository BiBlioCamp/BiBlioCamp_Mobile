// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bbc/acervo.dart';
import 'package:bbc/alocacoes.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/help.dart';
import 'package:bbc/profilepage.dart';
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

      backgroundColor: Colors.purple,
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
              icon: Icon(Icons.person, color: Colors.white,))
        ],
        backgroundColor: const Color.fromARGB(255, 40, 38, 70),
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
                              Text("Bibliocamp", style: TextStyle(color: Colors.white , fontSize: 60, fontWeight: FontWeight.bold),),
                              Text("A melhor maneira de gerenciar suas", style: TextStyle(color: Colors.white , fontSize: 20),),
                              Text("alocações da biblioteca do Campus da", style: TextStyle(color: Colors.white , fontSize: 20),),
                              Text("Unicamp de Limeira!", style: TextStyle(color: Colors.white , fontSize: 20),),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(29, 27, 49, 1)
              ),
              child: Center(
                child: 
                Padding(
                  padding: EdgeInsets.all(30),
                  child: 
                  
                  Row(children: [
                  Column(

                    

                      children: [SizedBox(height: 50,),
                        
                        Text("Objetivo", style: TextStyle(color: Colors.white, fontSize: 30),),
                        Text("Ajudar todos os alunos a terem", style: TextStyle(color: Colors.white),),
                        Text("um acesso mais facil a todas as", style: TextStyle(color: Colors.white),),
                        Text("funcionalidades da biblioteca", style: TextStyle(color: Colors.white),),
                        Text("do Campus!", style: TextStyle(color: Colors.white),),
                        SizedBox(height: 70,),
                      ],
                  ),
                  SizedBox(width: 30,),
                  
                  
                  
                  Column(children: [SizedBox(height: 50,),
                    Text("Oque temos", style: TextStyle(color: Colors.white, fontSize: 30),),
                    Text("Um aplicativo simples bonito e", style: TextStyle(color: Colors.white),),
                    Text("pratico que entrega", style: TextStyle(color: Colors.white),),
                    Text("exatamente oque quem entrou", style: TextStyle(color: Colors.white),),
                    Text("nele procurava!", style: TextStyle(color: Colors.white),),
SizedBox(height: 70,),

                  ]
                  )],)
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
                      SizedBox(height: 50,),
                          Text("O site somente funciona para alunos da escola!", style: TextStyle(color: Colors.white, fontSize: 15),),
                          Text("Para se registrar use seu email Unicamp", style: TextStyle(color: Colors.white), ),
                          Text("(cl......@g.unicamp.br)", style: TextStyle(color: Colors.white),)
                      
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
          }, icon: Icon(Icons.house, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            if(savedName == null || savedId == null){

            }else{
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Acervo())));
            }
          }, icon: Icon(Icons.book_outlined,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            if(savedId == null || savedName == null){

            }else{
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AlocacoesPage())));
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
