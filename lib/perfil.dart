// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bbc/acervo.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/user.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  User aluno = User.empty();
  Perfil(this.aluno,{super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
 
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

                          CircleAvatar( child: Image.asset('assets/images/PerfilLog.png'), radius: 50,),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.aluno.name, style: TextStyle(color: Colors.white , fontSize: 25, fontWeight: FontWeight.bold),),
                            SizedBox(height: 20,),
                            SizedBox(
                            width: 100,
                            height: 25,
                            child: FloatingActionButton(
                              onPressed: () => {               
                                setState(() {}),
                              },
                              backgroundColor: Colors.black,
                              child: Text("Editar Perfil",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                              
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

                      SizedBox(height: 25,),

                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Atualmente lendo:", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),)
                        ],
                       ),

                      SizedBox(height: 30,),

                      Row(
                        
                      mainAxisAlignment: MainAxisAlignment.center,  
                      children: [
                      
                      Column(children: [

                       Image.network('https://m.media-amazon.com/images/I/81QnqHwRiUL._AC_UF1000,1000_QL80_.jpg', width: 170,),
                       Text("Harry Potter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],),
                      
                      SizedBox(width: 50,),

                       Column(children: [

                       Image.network('https://m.media-amazon.com/images/I/71kzs3gIwpL._AC_UF1000,1000_QL80_.jpg', width: 170,),
                       Text("Morangos Mofados", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],),
                    ],),

                      SizedBox(height: 50,),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Column(children: [
                        Image.network('https://m.media-amazon.com/images/I/715ejknjS4L._UF894,1000_QL80_.jpg', width: 170,),
                       Text("A Esperança", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],),],),
          

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
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Index())));
          }, icon: Icon(Icons.home_outlined, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Acervo())));
          }, icon: Icon(Icons.book,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            
            
          }, icon: Icon(Icons.inbox_outlined,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Help())));
          }, icon: Icon(Icons.question_mark_rounded,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
          }, icon: Icon(Icons.person,color: Colors.white, size: 40,)),
        ],),
      ),
    );
  }
}