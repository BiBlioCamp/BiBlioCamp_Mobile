import 'dart:convert';
import 'package:bbc/class/aloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AlocRepository {
  final String _baseUrl = 'http://localhost:8080'; // Substitua pelo endereço correto do servidor

  Future<List<String>> buscarLivrosEmPosse(int userId) async {
    final response = await http.get(Uri.parse("$_baseUrl/Aloc/livrosEmPosse/$userId"));
    if (response.statusCode == 200) {
      List<String> livrosEmPosse = List<String>.from(jsonDecode(response.body));
      return livrosEmPosse;
    } else {
      throw Exception("Erro ao buscar livros em posse");
    }
  }

  Future<bool> alocarLivro({
    required int userId,
    required int bookId,
    required DateTime alocDate,
    required DateTime returnDate,
    required String status,
  }) async {
    try {
      // Formatação das datas no formato esperado pela API
      final String alocDateFormatted = DateFormat('dd/MM/yyyy').format(alocDate);
      final String returnDateFormatted = DateFormat('dd/MM/yyyy').format(returnDate);

      // Criação do JSON a ser enviado
      final Map<String, dynamic> alocData = {
        'userId': userId,
        'bookId': bookId,
        'alocDate': alocDateFormatted,
        'returnDate': returnDateFormatted,
        'status': status,
      };

      final url = Uri.parse('$_baseUrl/Aloc/insert'); // Substitua pelo endpoint correto
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(alocData),
      );

      if (response.statusCode == 200) {
        print("Alocação realizada com sucesso.");
        return true;
      } else {
        print("Falha na alocação: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erro ao tentar alocar o livro: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> buscarAlocacoesPorUsuario(int userId) async {
    final response = await http.get(Uri.parse("$_baseUrl/Aloc/select/$userId"));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> alocacoes = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      return alocacoes;
    } else {
      throw Exception("Erro ao buscar alocações");
    }
  }

  Future<bool> cancelarAlocacao(int userId, int bookId) async {
    final response = await http.delete(Uri.parse("$_baseUrl/Aloc/delete/$userId/$bookId"));
    return response.statusCode == 200;
  }

  List<Aloc> _listaAloc = [];

  List<Aloc> get listaAloc => this.listaAloc;

  set listaAloc(List<Aloc> value) => this._listaAloc = value;
}
