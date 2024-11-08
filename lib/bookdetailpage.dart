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

  Future<void> reducStock () async {
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

    if (alocDate != null && userId != null) {
      bool success = await AlocRepository().alocarLivro(
        userId: int.parse(savedId.toString()),
        bookId: int.parse(savedBookId.toString()),
        alocDate: alocDate!,
        returnDate: returnDate!,
        status: "retirar",
      );

      if (success) {
        
        reducStock();
        setState(() {
          
        });
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
        SnackBar(content: Text('Por favor, selecione uma data de retirada.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadSessionData();
    return Scaffold(
      appBar: AppBar(
          title: Text("Alocação de ${widget.book.title}"),
          leading: IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Acervo()));
          }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Título: ${widget.book.title}", style: TextStyle(fontSize: 20)),
            Text("Autor: ${widget.book.author}", style: TextStyle(fontSize: 18)),
            Text("Estoque disponível: ${widget.book.actualStock}", style: TextStyle(fontSize: 18, color: Colors.green)),

            SizedBox(height: 20),
            Text("Data de Retirada:"),
            Row(
              children: [
                Text(alocDate == null
                    ? "Selecione uma data"
                    : DateFormat('dd/MM/yyyy').format(alocDate!)),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectAlocDate(context),
                ),  
              ],
            ),
            SizedBox(height: 10),
            Text("Data de Devolução: ${returnDate != null ? DateFormat('dd/MM/yyyy').format(returnDate!) : ''}"),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _alocarLivro,
              child: Text("Alocar"),
            ),
          ],
        ),
      ),
    );
  }
}