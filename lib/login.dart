// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:bbc/index.dart';
import 'package:bbc/user.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController(), passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController(), raController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController(); bool manterLog = false;
  List<User> userList = [
    User("joao@gmail.com", "Joao", "Joao", 202235),
    User("enrique@gmail.com", "Enrique", "Enrique", 202207),
    User("jedson@gmail.com", "Jedson", "Jedson", 202158),
    User("julya@gmail.com", "Julya", "Julya", 202206),
    User("gabriel@gmail.com", "Gabriel", "Gabriel", 202238),
  ];

  void cleanForm() {
    
  }

  void saveUser() {
    
    cleanForm();
  }

  void showList() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        actions: [
          IconButton(onPressed: () {
            Center();
            Navigator.push(context, MaterialPageRoute(builder: ((context) => Index())));
          }, icon: Icon(Icons.square))
          ],
       centerTitle: true,
        backgroundColor: Color.fromARGB(255, 24, 24, 26),
         ),
      body: Container(
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
                            Text("Logar-se", style: TextStyle(color: Colors.white, fontSize: 34)),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                prefixIcon: Icon(Icons.mail),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Email',

                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                hintText: 'Senha',
                                prefixIcon: Icon(Icons.password),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),                                         
                            SizedBox(height: 20),
                            SizedBox(
                              width: 340,
                              child: FloatingActionButton(
                                onPressed: () => {
                                  
                                  setState((){}),
                                },
                                backgroundColor: Colors.blue[400],
                                child: Text("Entrar", style: TextStyle(color: Colors.white)),
                              ),       
                            ),
                            SizedBox(height: 15,),
                            
                              Row( mainAxisAlignment: MainAxisAlignment.start,
                                children: [ 
                                  Switch(value: manterLog,
                                  activeColor: Colors.blue,
                                  
                                  onChanged: (value) {
                                    manterLog = value!;
                                    setState(() {
                                      
                                    });
                                  },),
                                  SizedBox(width: 10,),
                                  Text("Manter Login", style: TextStyle(color: Colors.white),),
                                  SizedBox(width: 84,),
                                  
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cadastrar-se", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline, decorationColor: Colors.white),),
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
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 24, 24, 26),
        height: 75, 
        child: Row(
          children: [
            
          ],
        ),
      ),
    );
  }
}