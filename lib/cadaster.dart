// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unrelated_type_equality_checks, use_build_context_synchronously
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/login.dart';
import 'package:bbc/class/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cadaster extends StatefulWidget {
  const Cadaster({super.key});

  @override
  State<Cadaster> createState() => _CadasterState();
}

class _CadasterState extends State<Cadaster> {
  GlobalKey<FormState> validatorKey = GlobalKey();

  bool verifica = false;

  String mensagemCad = "";
  String mensagemDados = "";

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController(),
      raController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  List<User> userList = [
    User("joao@g.unicamp.br", "Joao", "Joao", 202235),
    User("enrique@g.unicamp.br", "Enrique", "Enrique", 202207),
    User("jedson@g.unicamp.br", "Jedson", "Jedson", 202158),
    User("julya@g.unicamp.br", "Julya", "Julya", 202206),
    User("gabriel@g.unicamp.br", "Gabriel", "Gabriel", 202238),
  ];

  void verificaCad() {
    for (var users in userList) {
      if (emailController.text == users.email &&
          int.parse(raController.text) == users.ra) {
        verifica = true;
        mensagemCad = "Email e RA já cadastrados!";
        break;
      } else if (emailController.text == users.email) {
        verifica = true;
        mensagemCad = "Email já cadastrado!";
        break;
      } else if (int.parse(raController.text) == users.ra) {
        verifica = true;
        mensagemCad = "RA já cadastrado!";
        break;
      } else {
        verifica = false;
        mensagemCad = "";
      }
    }
  }

  bool verificaNumber() {
    List<String> alfabeto = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      'z'
    ];
    bool letras = false;
    for (var L in alfabeto) {
      if (raController.text.toUpperCase().contains(L.toUpperCase())) {
        letras = true;
        break;
      }
    }
    return letras;
  }

  void limpar() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    raController = TextEditingController();
  }

  Future<void> salvarAluno() async{
    var url = Uri.parse("http://localhost:8080/Account/insert");
    var response = await http.post(
      url,
      headers: {'Content-Type':'application/json; charset=UTF-8'},
      body: jsonEncode(
        {
          "id": raController.text,
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "username": nameController.text,
          "active": 1,
          "type": 1,
        }
      )
    );

    if(response.statusCode == 200){
      Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Login())));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Center();
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Index())));
              },
              icon: Icon(Icons.home, color: Colors.white,))
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 40, 38, 70),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 24, 24, 26),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Index())));
                },
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 40,
                )),
            IconButton(
                onPressed: () {
                },
                icon: Icon(
                  Icons.book,
                  color: Colors.white,
                  size: 40,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.inbox_outlined,
                  color: Colors.white,
                  size: 40,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Help())));
                },
                icon: Icon(
                  Icons.question_mark_rounded,
                  color: Colors.white,
                  size: 40,
                )),
            IconButton(
                onPressed: () {
                },
                icon: Icon(
                  Icons.person_outlined,
                  color: Colors.white,
                  size: 40,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                padding: EdgeInsets.fromLTRB(50, 114.5, 50, 114.5),
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
                            Text("Cadastrar-se",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 34)),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                prefixIcon: Icon(Icons.mail),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Email',
                                errorStyle: TextStyle(color: Colors.white,),
                              ),
                              validator: (value) {
                                if (emailController.text.isEmpty) {
                                  return "O campo deve ser informado";
                                } else if (emailController.text
                                        .contains("@g.unicamp.br") ==
                                    false) {
                                  return "O email deve ser da Unicamp";
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
                                errorStyle: TextStyle(color: Colors.white),
                              ),
                              validator: (value) {
                                if (passwordController.text.isEmpty) {
                                  return "O campo deve ser informado";
                                } else if (passwordController.text.length < 5) {
                                  return "A senha precisa ter 5 ou mais caracteres";
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: "Confirme a senha",
                                prefixIcon: Icon(Icons.password),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: TextStyle(color: Colors.white),
                              ),
                              validator: (value) {
                                if (confirmPasswordController.text.isEmpty) {
                                  return "O campo deve ser informado";
                                } else if (confirmPasswordController.text !=
                                    passwordController.text) {
                                  return "Senha distinta";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Dados Pessoais",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 34)),
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: "Nome",
                                prefixIcon: Icon(Icons.abc),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: TextStyle(color: Colors.white),
                              ),
                              validator: (value) {
                                if (nameController.text.isEmpty) {
                                  return "O campo deve ser informado";
                                } else if (nameController.text.length < 3) {
                                  return "Nome precisa ter 3 ou mais caracteres";
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: raController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: "RA",
                                prefixIcon: Icon(Icons.numbers),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: TextStyle(color: Colors.white),
                              ),
                              validator: (value) {
                                if (raController.text.isEmpty) {
                                  return "O campo deve ser informado";
                                } else {
                                  bool letras = verificaNumber();
                                  if (letras == true) {
                                    return "O RA deve ser composto apenas por números";
                                  } else if (raController.text.length != 6) {
                                    return "O RA deve ter 6 números";
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 15),
                            Text(
                              mensagemCad,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 340,
                              child: FloatingActionButton(
                                onPressed: () => {
                                  if (validatorKey.currentState!.validate())
                                    {
                                      verificaCad(),
                                      if (verifica == false)
                                        {
                                          salvarAluno(),
                                        },
                                    },
                                  setState(() {}),
                                },
                                backgroundColor: Colors.blue[400],
                                child: Text("Confirmar",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Login(),
                                          ));
                                    },
                                    child: Text(
                                      "Já é cadastrado  ",
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
        )),
      ),
    );
  }
}
