import 'dart:convert';
import 'package:bbc/acervo.dart';
import 'package:bbc/class/book.dart';
import 'package:bbc/repository/alocRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AlocacoesPage extends StatefulWidget {
  @override
  _AlocacoesPageState createState() => _AlocacoesPageState();
}

class _AlocacoesPageState extends State<AlocacoesPage> {
  AlocRepository alocRepository = AlocRepository();
  String? userId;
  List<Map<String, dynamic>> alocacoes = [];
  List<Book> livrosExibidos = [];
  bool isLoading = true; // Para controlar o estado de carregamento

  @override
  void initState() {
    super.initState();
    _loadSessionData();
  }

  Future<void> _loadSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id');
    });

    if (userId != null && userId!.isNotEmpty) {
      await _loadAlocacoes();
    } else {
      setState(() {
        isLoading = false; // Encerrar o estado de carregamento se userId for nulo ou vazio
      });
    }
  }

  Future<void> _loadAlocacoes() async {
    try {
      List<Map<String, dynamic>> alocacoes = await alocRepository.buscarAlocacoesPorUsuario(int.parse(userId!));
      setState(() {
        this.alocacoes = alocacoes;
      });

      for (var aloc in alocacoes) {
        await carregaLivro(aloc['bookId']);
      }
    } catch (e) {
      print("Erro ao carregar alocações: $e");
    } finally {
      setState(() {
        isLoading = false; // Fim do estado de carregamento mesmo em caso de erro
      });
    }
  }

  Future<void> carregaLivro(int bookId) async {
    try {
      var url = Uri.parse("http://localhost:8080/Book/id/$bookId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> bookMap = jsonDecode(utf8.decode(response.bodyBytes));
        Book book = Book.fromJson(bookMap);
        setState(() {
          livrosExibidos.add(book);
        });
      } else {
        print("Erro ao carregar livro: Código ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao carregar livro: $e");
    }
  }

  Future<void> _confirmCancelAlocacao(int userId, int bookId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // O usuário deve tocar no botão
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text('Confirmar Cancelamento', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você tem certeza que deseja cancelar esta alocação?', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                Navigator.pop(context);
                await _cancelarAlocacao(userId, bookId);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> plusStock(int bookId) async {
    try {
      var url = Uri.parse("http://localhost:8080/Book/ActualStock/plus/$bookId");
      var response = await http.put(url);
      if (response.statusCode == 200) {
        print("Stock aumentado no livro de ID: $bookId");
      } else {
        print("Erro ao atualizar o Stock: Código ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao atualizar Stock: $e");
    }
  }

  Future<void> _cancelarAlocacao(int userId, int bookId) async {
    try {
      bool success = await alocRepository.cancelarAlocacao(userId, bookId);
      if (success) {
        plusStock(bookId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alocação cancelada com sucesso!')),
        );
        await _loadAlocacoes(); // Recarregar as alocações
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao cancelar a alocação.')),
        );
      }
    } catch (e) {
      print("Erro ao cancelar alocação: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cancelar a alocação.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 27, 49, 1),
      appBar: AppBar(
        title: Text("Minhas Alocações", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 40, 38, 70),
        leading: IconButton(onPressed:() {
          Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Acervo())));
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userId == null || userId!.isEmpty
              ? Center(child: Text("Erro ao carregar o ID do usuário.", style: TextStyle(color: Colors.white)))
              : alocacoes.isEmpty
                  ? Center(child: Text("Nenhuma alocação encontrada.", style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      itemCount: alocacoes.length,
                      itemBuilder: (context, index) {
                        final aloc = alocacoes[index];
                        final livro = livrosExibidos.firstWhere((book) => book.id == aloc['bookId'], orElse: () => Book());

                                                return Card(
                          color: Colors.grey[850], // Cor do card no modo escuro
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  livro.title.isNotEmpty ? livro.title : 'Título não disponível',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                livro.cover.isNotEmpty
                                    ? Image.asset(
                                        "assets/images/covers/${livro.cover}",
                                        width: 100,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 100,
                                        height: 150,
                                        color: Colors.grey,
                                        child: Center(child: Text('Sem capa', style: TextStyle(color: Colors.white))),
                                      ),
                                SizedBox(height: 10),
                                Text("Data de Alocação: ${aloc['alocDate'] ?? 'Data não disponível'}", style: TextStyle(color: Colors.white)),
                                Text("Data de Devolução: ${aloc['returnDate'] ?? 'Data não disponível'}", style: TextStyle(color: Colors.white)),
                                Text("Status: ${aloc['status'] ?? 'Status não disponível'}", style: TextStyle(color: Colors.white)),
                                SizedBox(height: 10),
                                aloc['status'] == "retirar"
                                    ? ElevatedButton(
                                        onPressed: () {
                                          _confirmCancelAlocacao(int.parse(userId!), aloc['bookId']);
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                        child: Text("Cancelar Alocação", style: TextStyle(color: Colors.white),),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
