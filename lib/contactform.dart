// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code

import 'package:bbc/acervo.dart';
import 'package:bbc/alocacoes.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

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
      backgroundColor: Colors.blue,
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
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 40, 38, 70),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 24, 24, 26),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(onPressed: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Index())));
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
      body: SingleChildScrollView(child: 
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
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(60, 24, 24, 26),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Text("Formulário de Contato",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 34),
                              textAlign: TextAlign.center),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Icon(Icons.abc),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Nome:',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: true,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'Email:',
                              prefixIcon: Icon(Icons.mail),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: messageController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: "Mensagem:",
                                filled: true,
                                fillColor: Colors.white,
                          ),),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 340,
                            child: FloatingActionButton(
                              onPressed: () => {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) => Index()))),
                                setState(() {}),
                              },
                              backgroundColor: Colors.blue[400],
                              child: Text("Enviar",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      )
    );
  }
}
