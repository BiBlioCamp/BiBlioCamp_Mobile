// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:bbc/acervo.dart';
import 'package:bbc/alocacoes.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/editprofilepage.dart';
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/class/user.dart';
import 'package:bbc/class/account.dart';
import 'package:bbc/repository/accountRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class Perfil extends StatefulWidget {
  Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  String? savedName;
  String? savedId;
  Account? _account;
  final AccountRepository _accountRepository = AccountRepository();

  Future<void> _loadSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('name');
      savedId = prefs.getString('id');
    });
  }

  Future<void> _loadAccountData() async {
    if (savedId != null) {
      Account? account = await _accountRepository.buscarContaPorId(int.parse(savedId!));
      setState(() {
        _account = account;
        savedName = account?.name;
      });
    }
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Limpa todas as preferências salvas
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Index()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _confirmLogout() async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação de Logout'),
          content: Text('Você realmente deseja sair?'),
          actions: <Widget>[
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false); // Retorna falso para cancelar
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true); // Retorna verdadeiro para confirmar
              },
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      _logout();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSessionData().then((_) => _loadAccountData());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAccountData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(29, 27, 49, 1),
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logobbc.png',
          width: 50,
        ),
        actions: [
          IconButton(
            onPressed: _confirmLogout,
            icon: Icon(Icons.exit_to_app, color: Colors.white,),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 40, 38, 70),
      ),
      body: _account == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
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
                                  Image.asset(
                                    'assets/images/PerfilLog.png',
                                    width: 150,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        savedName ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        savedId ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 40),
                                      
                                  
                                      SizedBox(
                                        height: 50,
                                        width: 150,
                                        child: ElevatedButton(style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color.fromRGBO(29, 27, 49, 1),
                                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                        ),
                                        onPressed: () {
                                        setState(() {
                  
                                        });
                                        Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditProfilePage(
                                                  account: _account!,
                                                ),
                                              ),
                                            ).then((result) {
                                              if (result == true) {
                                                _loadAccountData();
                                              }
                                            });
                                            },
                                            child: Text("Editar Perfil")),
                                       
                                      ),
                                    ],
                                  ),
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
                      decoration: BoxDecoration(color: Color.fromRGBO(29, 27, 49, 1),),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ler é um ato de abrir portais \ninfinitos: \nCada livro é uma chave para\n novas perspectivas, um convite \nà introspecção e uma viagem\n pelas vastas paisagens do\n conhecimento e da\n imaginação.",
                                    style: GoogleFonts.satisfy(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
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
          }, icon: Icon(Icons.house_outlined, color: Colors.white, size: 40,)),
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
      
            }
          }, icon: Icon(Icons.person,color: Colors.white, size: 40,)),
        ],),
      ),
    );
  }
}
