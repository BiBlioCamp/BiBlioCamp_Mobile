import 'package:bbc/changepassword.dart';
import 'package:bbc/class/account.dart';
import 'package:bbc/repository/accountRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart'; // Importa a página Index para redirecionamento

class EditProfilePage extends StatefulWidget {
  final Account account;

  EditProfilePage({Key? key, required this.account}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final AccountRepository _accountRepository = AccountRepository();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.account.name; // Preenche o campo com o nome atual
  }

  String? savedName;
  String? savedId;

  Future<void> _showErrorDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text('Erro', style: TextStyle(color: Colors.white)),
          content: Text(message, style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showConfirmDialog() async {
    final TextEditingController _passwordController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text('Excluir Conta', style: TextStyle(color: Colors.redAccent)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita.", style: TextStyle(color: Colors.redAccent)),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Senha Atual", labelStyle: TextStyle(color: Colors.redAccent)),
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                _deleteAccount(_passwordController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('name');
      savedId = prefs.getString('id');
    });
  }

  Future<void> _clearSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('id');

    setState(() {
      savedName = null;
      savedId = null;
    });
  }

  Future<void> _deleteAccount(String currentPassword) async {
    String? storedPassword = await _accountRepository.buscarSenha(widget.account.id);
    if (storedPassword != currentPassword) {
      Navigator.of(context).pop();
      _showErrorDialog("Senha atual incorreta.");
      return;
    }

    bool accountDeleted = await _accountRepository.deletarConta(widget.account.id);

    if (accountDeleted) {
      Navigator.of(context).pop(); // Fechar o diálogo de confirmação
      _clearSessionData();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Index()), // Redireciona para a página Index
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.of(context).pop();
      _showErrorDialog("Falha ao excluir conta.");
    }
  }

  Future<void> _saveProfileChanges() async {
    bool nameUpdated = await _accountRepository.alterarNome(_nameController.text, widget.account.username, widget.account.id);

    if (nameUpdated) {
      Navigator.pop(context, true); // Retornar para a ProfilePage com sucesso
    } else {
      _showErrorDialog("Falha ao atualizar perfil.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 27, 49, 1),
      appBar: AppBar(
        title: Text("Editar Perfil", style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 40, 38, 70),
      ),
      body: SingleChildScrollView(child: 
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {});
                  _saveProfileChanges();
                },
                child: Text("Salvar Alterações"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(userId: widget.account.id),
                    ),
                  );
                },
                child: Text("Alterar Senha"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {});
                  _showConfirmDialog();
                },
                child: Text("Excluir Conta"),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}
