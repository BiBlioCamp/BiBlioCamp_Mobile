import 'dart:convert';
import 'package:bbc/class/account.dart';
import 'package:http/http.dart' as http;

class AccountRepository {
  final String baseUrl = "http://localhost:8080/Account"; // substitua pelo URL da sua API

  Future<Account?> buscarContaPorId(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/select/$id"));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool> alterarNome(String name, String username, int id) async {
    final response = await http.put(
      Uri.parse("$baseUrl/update/name/$name/$username/$id"),
      headers: {"Content-Type": "application/json"},
    );
    return response.statusCode == 200;
  }

  Future<bool> alterarEmail(String email, int id) async {
    final response = await http.put(
      Uri.parse("$baseUrl/update/email/$email/$id"),
      headers: {"Content-Type": "application/json"},
    );
    return response.statusCode == 200;
  }

  Future<String?> buscarSenha(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/select/password/$id"));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  Future<bool> alterarSenha(String password, int id) async {
    final response = await http.put(
      Uri.parse("$baseUrl/update/password/$password/$id"),
      headers: {"Content-Type": "application/json"},
    );
    return response.statusCode == 200;
  }

  Future<Account?> buscarEmailSenha(String email, String password) async {
    final response = await http.get(Uri.parse("$baseUrl/select/$email/$password"));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Account?> buscarEmail(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/select/email/$email"));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool> inserirConta(Account account) async {
    final response = await http.post(
      Uri.parse("$baseUrl/insert"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": account.name,
        "email": account.email,
        "password": account.password,
        "username": account.username,
        "active": account.active,
        "type": account.type,
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> deletarConta(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/delete/$id"));
    return response.statusCode == 200;
  }
}
