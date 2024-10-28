// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, must_be_immutable, unused_element, unused_import

import 'package:bbc/acervo.dart';
import 'package:bbc/class/account.dart';
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/perfil.dart';
import 'package:bbc/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> validatorKey = GlobalKey();

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController(),
      raController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool existeLog = false;
  bool manterLog = false;

  String dados = "";
  String mensagemLog = "";
  String? savedName;
  String? savedId;

  Account acc = Account();

  List<User> userList = [
    User("joao@g.unicamp.br", "Joao", "Joao", 202235),
    User("enrique@g.unicamp.br", "Enrique", "Enrique", 202207),
    User("jedson@g.unicamp.br", "Jedson", "Jedson", 202158),
    User("julya@g.unicamp.br", "Julya", "Julya", 202206),
    User("gabriel@g.unicamp.br", "Gabriel", "Gabriel", 202238),
  ];

  Future<void> requisicao() async{
   var url = Uri.parse('http://localhost:8080/Account/select/' + emailController.text + '/' + passwordController.text);
    http.Response response = await http.get(url);
    dados = response.body;
    Map<String, dynamic> formatedData = jsonDecode(dados);
    acc = Account.fromJson(formatedData);
    if(response.statusCode==200){
        setState(() {
          _saveSessionData();
          Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Perfil())));
        });
    }
  }
  

   Future<void> _saveSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', acc.name);
    await prefs.setString('id', acc.id.toString());

    setState(() {
      savedName = acc.name;
      savedId = acc.id.toString();
    });
  }

  Future<void> _loadSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('name');
      savedId = prefs.getString('id');
    });
  }

  Future<void> _clearSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('id');

    setState(() {
      savedName = null;
      savedId = null;
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
                Center();
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Index())));
              },
              icon: Icon(Icons.home))
        ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 24, 24, 26),
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

          }, icon: Icon(Icons.person_outlined,color: Colors.white, size: 40,)),
        ],),
      ),
      body: Container(
        child: Form(
          key: validatorKey,
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
                          Text("Logar-se",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 34)),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Icon(Icons.mail),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email',
                              errorStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if(emailController.text.isEmpty){
                                return "O campo deve ser informado";
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'Senha',
                              prefixIcon: Icon(Icons.password),
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: TextStyle(color: Colors.white,),
                            ),
                            validator: (value) {
                              if(passwordController.text.isEmpty){
                                return "O campo deve ser informado";
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Text(mensagemLog,style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,),),
                          SizedBox(height: 15,),
                          SizedBox(
                            width: 340,
                            child: FloatingActionButton(
                              onPressed: () => {
                                if(validatorKey.currentState!.validate()){
                                requisicao(),
                                },
                                setState(() {}),
                              },
                              backgroundColor: Colors.blue[400],
                              child: Text("Entrar",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Switch(
                                value: manterLog,
                                activeColor: Colors.blue,
                                onChanged: (value) {
                                  manterLog = value;
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Manter Login",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 95,
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cadastre-se",
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
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
    ),
  );
}
}
