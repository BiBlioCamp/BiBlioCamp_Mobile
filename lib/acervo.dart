import 'package:bbc/alocacoes.dart';
import 'package:bbc/class/account.dart';
import 'package:bbc/class/book.dart';
import 'package:bbc/help.dart';
import 'package:bbc/index.dart';
import 'package:bbc/profilepage.dart';
import 'package:bbc/repository/accountRepository.dart';
import 'package:bbc/repository/bookRepository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:bbc/bookdetailpage.dart';

class Acervo extends StatefulWidget {
  const Acervo({Key? key}) : super(key: key);

  @override
  State<Acervo> createState() => _AcervoState();
}

class _AcervoState extends State<Acervo> {
  BookRepository bookRepository = BookRepository();
  List<Book> livrosExibidos = [];
  final TextEditingController _searchController = TextEditingController();
  late Future<void> livrosCarregados;

  int bookId = 0;
  String? savedName;
  String? savedId;
  String? savedBookId;
  Account? _account;
  final AccountRepository _accountRepository = AccountRepository();

  Future<void> _loadSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
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

  Future<void> carregaLivros() async {
    try {
      var url = Uri.parse("http://localhost:8080/Book/todos");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List bookList = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        bookRepository.listaBook = bookList.map((book) => Book.fromJson(book)).toList();
        setState(() {
          livrosExibidos = bookRepository.listaBook;
        });
        print("Livros carregados com sucesso: ${livrosExibidos.length}");
      } else {
        print("Erro ao carregar livros: Código ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao carregar livros: $e");
    }
  }

  Future<void> incrementarAcessos(int bookId) async {
    try {
      var url = Uri.parse("http://localhost:8080/Book/updateAcesses/$bookId");
      var response = await http.put(url);
      if (response.statusCode == 200) {
        print("Acesso incrementado para o livro ID: $bookId");
      } else {
        print("Erro ao incrementar acessos: Código ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao incrementar acessos: $e");
    }
  }

  Future<void> _saveSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookId', bookId.toString());

    setState(() {
      savedBookId = bookId.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    livrosCarregados = carregaLivros();
    _searchController.addListener(_filtrarLivros);
  }

  void _filtrarLivros() {
    setState(() {
      livrosExibidos = bookRepository.listaBook
          .where((book) => book.title.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 16, 29),
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logobbc.png',
          width: 50,
        ),
        title: Text("Acervo de livros", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Perfil()),
              );
            },
            icon: Icon(Icons.person, color: Colors.white,),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 40, 38, 70),
      ),
            body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white), // Texto no modo escuro
              decoration: InputDecoration(
                hintText: 'Pesquisar livro',
                hintStyle: TextStyle(color: Colors.grey), // Cor do texto do placeholder no modo escuro
                prefixIcon: const Icon(Icons.search, color: Colors.white), // Ícone no modo escuro
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.white), // Borda no modo escuro
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Borda habilitada no modo escuro
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Borda focada no modo escuro
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: livrosCarregados,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Erro ao carregar livros", style: TextStyle(color: Colors.white)));
                } else if (livrosExibidos.isEmpty) {
                  return const Center(child: Text("Nenhum livro disponível.", style: TextStyle(color: Colors.white)));
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: livrosExibidos.length,
                    itemBuilder: (context, index) {
                      final livro = livrosExibidos[index];
                      return GestureDetector(
                        onTap: () async {
                          await incrementarAcessos(livro.id); // Incrementa acessos ao clicar
                          bookId = livro.id;
                          _saveSessionData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailPage(book: livro),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/covers/${livro.cover}",
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              livro.title,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // Texto no modo escuro
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              livro.author,
                              style: const TextStyle(fontSize: 14, color: Colors.white), // Texto no modo escuro
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color:Colors.black,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Index())));
          }, icon: Icon(Icons.house_outlined, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.book,color: Colors.white, size: 40,)),
          IconButton(onPressed: () {
            
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AlocacoesPage())));
            
          }, icon: Icon(Icons.inbox_outlined,color: Colors.white, size: 40,)),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
