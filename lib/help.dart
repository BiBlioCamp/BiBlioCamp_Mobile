// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bbc/acervo.dart';
import 'package:bbc/alocation.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/contact.dart';
import 'package:bbc/index.dart';
import 'package:bbc/perfil.dart';
import 'package:bbc/user.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
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
                          Image.asset('assets/images/helpImage.png' , width: 100,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Duvidas Frequentes", style: TextStyle(color: Colors.white , fontSize: 30, fontWeight: FontWeight.bold),),
                              Text("Esta com algum problema?", style: TextStyle(color: Colors.white , fontSize: 18),),
                              Text("Veja algumas duvidas que", style: TextStyle(color: Colors.white , fontSize: 18),),
                              Text("frequentemente são", style: TextStyle(color: Colors.white , fontSize: 18),),
                              Text("enviadas para nós!", style: TextStyle(color: Colors.white , fontSize: 18),),
                              
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
                color: Colors.white
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


          SizedBox(height: 59.4,),  
          const ExpansionTile(
          title: Text('Problemas com alocação de livros', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('Lorem ipsum?')),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas com Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('Lorem ipsum?')),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas com Cadastro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('Lorem ipsum?')),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas ao procurar um livro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('Lorem ipsum?')),
          ],
        ),
        SizedBox(height: 60),


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
                              Text("Não conseguiu resolver o seu problema?", style: TextStyle(color: Colors.white , fontSize: 20, fontWeight: FontWeight.bold),),
                              
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Contact()));
                                  },
                                  child: Text(
                                    "Entre em contato conosco!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 0.5,)
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
            Navigator.push(context, MaterialPageRoute(builder: ((context) => Index())));
          }, icon: Icon(Icons.info_outlined, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Acervo())));
          }, icon: Icon(Icons.book,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Alocation())));
          }, icon: Icon(Icons.inbox_outlined,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.question_mark_rounded,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Perfil())));
          }, icon: Icon(Icons.person_outlined,color: Colors.white, size: 40,)),
        ],),
      ),
    );
  }
}