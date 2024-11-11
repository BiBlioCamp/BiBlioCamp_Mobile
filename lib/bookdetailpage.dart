import 'package:bbc/acervo.dart';
import 'package:bbc/class/book.dart';
import 'package:bbc/repository/alocRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({required this.book, Key? key}) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  DateTime? alocDate;
  DateTime? returnDate;

  String? savedName;
  String? savedId;
  String? savedBookId;

  void _selectAlocDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // Tema escuro para o seletor de datas
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != alocDate) {
      setState(() {
        alocDate = pickedDate;
        returnDate = pickedDate.add(Duration(days: 7)); // Return date 7 days after alocDate
      });
    }
  }

  Future<void> _loadSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('name');
      savedId = prefs.getString('id');
      savedBookId = prefs.getString('bookId');
    });
  }

  Future<void> reducStock() async {
    try {
      var url = Uri.parse("http://localhost:8080/Book/ActualStock/less/$savedBookId");
      var response = await http.put(url);
      if (response.statusCode == 200) {
        print("Stock diminuido no livro de ID: $savedBookId");
      } else {
        print("Erro ao atualizar o Stock: Código ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao atualizar Stock: $e");
    }
  }

  Future<void> _alocarLivro() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = savedId;

    if (alocDate != null && userId != null && widget.book.actualStock > 0) {
      bool success = await AlocRepository().alocarLivro(
        userId: int.parse(savedId.toString()),
        bookId: int.parse(savedBookId.toString()),
        alocDate: alocDate!,
        returnDate: returnDate!,
        status: "retirar",
      );

      if (success) {
        await reducStock();
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Livro alocado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao alocar o livro.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao alocar o livro, verifique as informações.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadSessionData();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 16, 29),
      appBar: AppBar(
        title: Text("Alocação de ${widget.book.title}", style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Acervo()),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 40, 38, 70),
      ),
      body: SingleChildScrollView(child: 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/images/covers/${widget.book.cover}",
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text("Título: ${widget.book.title}", style: TextStyle(fontSize: 20, color: Colors.white)),
            Text("Autor: ${widget.book.author}", style: TextStyle(fontSize: 18, color: Colors.white)),
            Text("Estoque disponível: ${widget.book.actualStock}", style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 20),
            Text("Data de Retirada:", style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Text(
                  alocDate == null ? "Selecione uma data" : DateFormat('dd/MM/yyyy').format(alocDate!),
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () => _selectAlocDate(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Data de Devolução: ${returnDate != null ? DateFormat('dd/MM/yyyy').format(returnDate!) : ''}",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _alocarLivro,
                            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 40, 37, 71),
              ),
              child: Text("Alocar", style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      )
    );
  }
}
