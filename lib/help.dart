// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bbc/acervo.dart';
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


          SizedBox(height: 30,),  
          const ExpansionTile(
          title: Text('Problemas com Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('1: Verifique se os dados digitados estão realmente corretos.\n2: Tente alterar sua senha.\n3: Se não funcionar use formulário de contato!')),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas com Cadastro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('1: Verifique se os dados digitados estão realmente corretos.\n2: Se seus dados não forem veridicos o cadastro pode não funcionar.\n3: Se não funcionar use o formulário de contato!')),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas buscando livros', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('1: Talvez a biblioteca não possua este livro, tente conversar com o funcionario da biblioteca.\n2: Não use caracteres especiais.\n3: Tente pesquisar com apenas algumas letras do nome do livro.\n4: Tente pesquisar por variações do nome do livro.\n5: Se não funcionar use o formulário de contato!')),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas usando o formulário de contato', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('1: Verifique se o email não foi digitado incorretamente.\n2: O uso de palavras de baixo calão em sua mensagem podem barrar o envio do formulario.\n3: O site pode estar com problemas de conexão, tente novamente mais tarde.')),
          ],
        ),
        SizedBox(height: 30),

        const ExpansionTile(
          title: Text('Problemas com reservas?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('1: Verifique se não há um erro na hora de escolher a data.\n2: Verifique se o estoque do livro não acabou.\n3: O site pode estar com problemas de conexão, tente novamente mais tarde.\n4: Se não funcionar use o formulário de contato!')),
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
          }, icon: Icon(Icons.home_outlined, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Acervo())));
          }, icon: Icon(Icons.book,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            
            
          }, icon: Icon(Icons.inbox_outlined,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
          }, icon: Icon(Icons.question_mark_rounded,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Perfil(User("","","User",0)))));
          }, icon: Icon(Icons.person_outlined,color: Colors.white, size: 40,)),
        ],),
      ),
    );
  }
}