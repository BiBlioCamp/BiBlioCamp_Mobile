// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bbc/acervo.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/contactform.dart';
import 'package:bbc/index.dart';
import 'package:bbc/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {

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

      backgroundColor: Colors.black,

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
                color: Color.fromRGBO(29, 27, 49, 1),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


          SizedBox(height: 59.4,),  
          const ExpansionTile(
          title: Text('Problemas com login?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
          controlAffinity: ListTileControlAffinity.leading,
          collapsedIconColor: Colors.white,
          children: <Widget>[
            ListTile(title: Text('1: Verifique se os dados digitados estão realmente corretos.', style: TextStyle(color: Colors.white),)),
            ListTile(title: Text('2: Tente alterar sua senha.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('3: Se não funcionar use o formulário de contato!', style: TextStyle(color: Colors.white),),),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas com cadastro?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
          controlAffinity: ListTileControlAffinity.leading,
          collapsedIconColor: Colors.white,
          children: <Widget>[
            ListTile(title: Text('1: Verifique se os dados digitados estão realmente corretos.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('2: Se seus dados não forem veridicos o cadastro pode não funcionar.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('3: Se não funcionar use o formulário de contato!', style: TextStyle(color: Colors.white),),),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas buscando por livros?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
          controlAffinity: ListTileControlAffinity.leading,
          collapsedIconColor: Colors.white,
          children: <Widget>[
            ListTile(title: Text('1: Talvez a biblioteca não possua este livro, tente conversar com o funcionario da biblioteca.', style: TextStyle(color: Colors.white),)),
            ListTile(title: Text('2: Não use caracteres especiais.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('3: Tente pesquisar com apenas algumas letras do nome do livro.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('4: Tente pesquisar por variações do nome do livro.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('5: Se não funcionar use o formulário de contato!', style: TextStyle(color: Colors.white),),),
          ],
        ),
        SizedBox(height: 30,),

        const ExpansionTile(
          title: Text('Problemas usando o formulario de contato?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
          controlAffinity: ListTileControlAffinity.leading,
          collapsedIconColor: Colors.white,
          children: <Widget>[
            ListTile(title: Text('1: Verifique se o email não foi digitado incorretamente.', style: TextStyle(color: Colors.white),)),
            ListTile(title: Text('2: O uso de palavras de baixo calão em sua mensagem podem barrar o envio do formulario.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('3: O site pode estar com problemas de conexão, tente novamente mais tarde.', style: TextStyle(color: Colors.white),),),
          ],
        ),
        SizedBox(height: 30),


        const ExpansionTile(
          title: Text('Problemas com reservas?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
          controlAffinity: ListTileControlAffinity.leading,
          collapsedIconColor: Colors.white,
          children: <Widget>[
            ListTile(title: Text('1: Verifique se não há um erro na hora de escolher a data.', style: TextStyle(color: Colors.white),)),
            ListTile(title: Text('2: Verifique se o estoque do livro não acabou.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('3: O site pode estar com problemas de conexão, tente novamente mais tarde.', style: TextStyle(color: Colors.white),),),
            ListTile(title: Text('4: Se não funcionar use o formulário de contato!', style: TextStyle(color: Colors.white),),),
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
            if(savedId == null || savedName == null){

            }else{
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Acervo())));
            }
          }, icon: Icon(Icons.book_outlined,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            if(savedId == null || savedName == null){

            }else{

            }
          }, icon: Icon(Icons.inbox_outlined,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            
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