// ignore_for_file: prefer_const_constructors

import 'package:bbc/class/account.dart';
import 'package:bbc/editprofilepage.dart';
import 'package:bbc/logout.dart';
import 'package:bbc/perfil.dart';
import 'package:flutter/material.dart';
import 'package:bbc/acervo.dart';
import 'package:bbc/bookDetailPage.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/contact.dart';
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Index(),
        '/cadastro': (context) => Cadaster(),
        '/login': (context) => Login(),
        '/contato': (context) => Contact(),
        '/help': (context) => Help(),
        '/perfil': (context) => Perfil(),
        '/acervo': (context) => Acervo(),
        '/logout': (context) => LogoutPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/editprofile') {
          final Account account = settings.arguments as Account;
          return MaterialPageRoute(
            builder: (context) => EditProfilePage(account: account),
          );
        }
        if (settings.name == '/index') { 
          return MaterialPageRoute( 
            builder: (context) => Index(), ); 
        }
        return null;
      },
    );
  }
}
