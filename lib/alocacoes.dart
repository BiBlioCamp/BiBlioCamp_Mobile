import 'package:bbc/repository/alocRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlocacoesPage extends StatefulWidget {
  @override
  _AlocacoesPageState createState() => _AlocacoesPageState();
}

class _AlocacoesPageState extends State<AlocacoesPage> {
  AlocRepository alocRepository = AlocRepository();
  String? userId;
  List<Map<String, dynamic>> alocacoes = [];
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
    } catch (e) {
      print("Erro ao carregar alocações: $e");
    } finally {
      setState(() {
        isLoading = false; // Fim do estado de carregamento mesmo em caso de erro
      });
    }
  }

  Future<void> _cancelarAlocacao(int userId, int bookId) async {
    bool success = await alocRepository.cancelarAlocacao(userId, bookId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Alocação cancelada com sucesso!')),
      );
      _loadAlocacoes(); // Recarregar as alocações
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao cancelar a alocação.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Alocações"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userId == null || userId!.isEmpty
              ? Center(child: Text("Erro ao carregar o ID do usuário."))
              : alocacoes.isEmpty
                  ? Center(child: Text("Nenhuma alocação encontrada."))
                  : ListView.builder(
                      itemCount: alocacoes.length,
                      itemBuilder: (context, index) {
                        final aloc = alocacoes[index];
                        return ListTile(
                          title: Text(aloc['bookTitle']),
                          subtitle: Text("Status: ${aloc['status']}"),
                          trailing: aloc['status'] == "retirar"
                              ? IconButton(
                                  icon: Icon(Icons.cancel, color: Colors.red),
                                  onPressed: () {
                                    _cancelarAlocacao(int.parse(userId!), aloc['bookId']);
                                  },
                                )
                              : null,
                        );
                      },
                    ),
    );
  }
}
