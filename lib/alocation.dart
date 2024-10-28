import 'package:bbc/acervo.dart';
import 'package:bbc/cadaster.dart';
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/perfil.dart';
import 'package:bbc/user.dart';
import 'package:flutter/material.dart';

class Alocation extends StatefulWidget {
  const Alocation({super.key});

  @override
  State<Alocation> createState() => _AlocationState();
}

class _AlocationState extends State<Alocation> {
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

      SingleChildScrollView(child:
      Column(children: [
        Padding(
                  padding: EdgeInsets.all(25),
                  child: 
Column(children: [

    Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  width: 3.0
                                  ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0) //                 <--- border radius here
                                              ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ALOCAÇÕES", style: TextStyle(color: Colors.red, fontSize: 50),)
                         ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
SizedBox(height: 20,),

    Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  width: 3.0
                                  ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //                 <--- border radius here
                                              ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network("https://m.media-amazon.com/images/I/81ibfYk4qmL._AC_UF350,350_QL50_.jpg", width: 120,),
                          SizedBox(width: 30,),
                          Column(children: [

                            Text("TITULO DO LIVRO", style: TextStyle( fontSize: 18,color: Colors.red),),
                            Text("xxxxxxxxxxxxxxxxxxx", style: TextStyle( fontSize: 10,color: Colors.white),),
                            SizedBox(height: 15,),
                            Text("DATA DE DEVOLUÇÃO", style: TextStyle(fontSize: 18, color: Colors.red),),
                            Text("XX/XX/XXXX", style: TextStyle( fontSize: 10,color: Colors.white),),
                            SizedBox(height: 15,),
                            Text("DIAS RESTANTES", style: TextStyle( fontSize: 18,color: Colors.red),),
                            Text("XXX", style: TextStyle( fontSize: 10,color: Colors.white),),
                          ],)
                         ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
SizedBox(height: 25,),




          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  width: 3.0
                                  ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //                 <--- border radius here
                                              ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network("https://m.media-amazon.com/images/I/81ibfYk4qmL._AC_UF350,350_QL50_.jpg", width: 120,),
                          SizedBox(width: 30,),
                          Column(children: [

                            Text("TITULO DO LIVRO", style: TextStyle( fontSize: 18,color: Colors.red),),
                            Text("xxxxxxxxxxxxxxxxxxx", style: TextStyle( fontSize: 10,color: Colors.white),),
                            SizedBox(height: 15,),
                            Text("DATA DE DEVOLUÇÃO", style: TextStyle(fontSize: 18, color: Colors.red),),
                            Text("XX/XX/XXXX", style: TextStyle( fontSize: 10,color: Colors.white),),
                            SizedBox(height: 15,),
                            Text("DIAS RESTANTES", style: TextStyle( fontSize: 18,color: Colors.red),),
                            Text("XXX", style: TextStyle( fontSize: 10,color: Colors.white),),
                          ],)
                         ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
SizedBox(height: 25,),




          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  width: 3.0
                                  ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //                 <--- border radius here
                                              ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network("https://m.media-amazon.com/images/I/81ibfYk4qmL._AC_UF350,350_QL50_.jpg", width: 120,),
                          SizedBox(width: 30,),
                          Column(children: [

                            Text("TITULO DO LIVRO", style: TextStyle( fontSize: 18,color: Colors.red),),
                            Text("xxxxxxxxxxxxxxxxxxx", style: TextStyle( fontSize: 10,color: Colors.white),),
                            SizedBox(height: 15,),
                            Text("DATA DE DEVOLUÇÃO", style: TextStyle(fontSize: 18, color: Colors.red),),
                            Text("XX/XX/XXXX", style: TextStyle( fontSize: 10,color: Colors.white),),
                            SizedBox(height: 15,),
                            Text("DIAS RESTANTES", style: TextStyle( fontSize: 18,color: Colors.red),),
                            Text("XXX", style: TextStyle( fontSize: 10,color: Colors.white),),
                          ],)
                         ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
SizedBox(height: 25,),

],)
        ),




      ],
      ),),




















bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 24, 24, 26),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(onPressed: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Index())));


          }, icon: Icon(Icons.info_outline, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Acervo())));
          }, icon: Icon(Icons.book,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.all_inbox,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context, 
                    MaterialPageRoute(builder: ((context) => Help())));
          }, icon: Icon(Icons.question_mark_rounded,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Perfil())));
          }, icon: Icon(Icons.person_outlined,color: Colors.white, size: 40,)),
        ],),
      ),
    );
  }
}