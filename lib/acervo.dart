// ignore_for_file: prefer_const_constructors

import 'package:bbc/cadaster.dart';
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/perfil.dart';
import 'package:bbc/user.dart';
import 'package:flutter/material.dart';

class Acervo extends StatefulWidget {
  const Acervo({super.key});

  @override
  State<Acervo> createState() => _AcervoState();
}

class _AcervoState extends State<Acervo> {

List<String> list = <String>['Romance', 'Aventura', 'Ação', 'Terror'];



  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
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
                          Image.asset('assets/images/acervo.png' , width: 200,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Acervo", style: TextStyle(color: Colors.white , fontSize: 40, fontWeight: FontWeight.bold),),
                              Text("Veja nossos", style: TextStyle(color: Colors.white , fontSize: 24),),
                              Text("livros!", style: TextStyle(color: Colors.white , fontSize: 24),),
                              
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
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'Livro $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),

          SizedBox(height: 60,),

                      Row(
                        
                      mainAxisAlignment: MainAxisAlignment.center,  
                      children: [
                      
                      Column(children: [

                       Image.network('https://m.media-amazon.com/images/I/81QnqHwRiUL._AC_UF1000,1000_QL80_.jpg', width: 170,),
                       Text("Harry Potter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],),
                      
                      SizedBox(width: 50,),

                      Column(children: [
                        Image.network('https://th.bing.com/th/id/OIP.x4TzFiPTeW69XbIn4Sex7wHaLu?rs=1&pid=ImgDetMain', width: 170,),
                       Text("Senhor dos Anéis", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],)],),
                      SizedBox(height: 20,),

                      Row(
                        
                      mainAxisAlignment: MainAxisAlignment.center,  
                      children: [
                      
                      Column(children: [

                       Image.network('https://m.media-amazon.com/images/I/81LKuhXOO7L._AC_UF1000,1000_QL80_.jpg', width: 170,),
                       Text("A Cor Purpura", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],),
                      
                      SizedBox(width: 50,),

                      Column(children: [
                        Image.network('https://m.media-amazon.com/images/I/51RjYjNVpRL._AC_UF1000,1000_QL80_.jpg', width: 170,),
                       Text("Olhos d'Água", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],)],),
                      SizedBox(height: 20,),

                      Row(
                        
                      mainAxisAlignment: MainAxisAlignment.center,  
                      children: [
                      
                      Column(children: [

                       Image.network('https://m.media-amazon.com/images/I/71kzs3gIwpL._AC_UF1000,1000_QL80_.jpg', width: 170,),
                       Text("Morangos Mofados", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],),
                      
                      SizedBox(width: 50,),

                      Column(children: [
                        Image.network('https://m.media-amazon.com/images/I/81TmOZIXvzL._AC_UF1000,1000_QL80_.jpg', width: 170,),
                       Text("O Pequeno Príncipe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],)],),
                      SizedBox(height: 20,),

                      Row(
                        
                      mainAxisAlignment: MainAxisAlignment.center,  
                      children: [
                      
                      Column(children: [

                       Image.network('https://m.media-amazon.com/images/I/8118F5EgmZL._AC_UF1000,1000_QL80_.jpg', width: 170,),
                       Text("Americanah", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],),
                      
                      SizedBox(width: 50,),

                      Column(children: [
                        Image.network('https://m.media-amazon.com/images/I/715ejknjS4L._UF894,1000_QL80_.jpg', width: 170,),
                       Text("A Esperança", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],)],),
                      SizedBox(height: 20,),

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
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
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
            
          }, icon: Icon(Icons.menu_book_rounded,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.inbox_outlined,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Help())));
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

