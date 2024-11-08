import 'package:flutter/material.dart';
import 'package:bbc/repository/accountRepository.dart';

class ChangePasswordPage extends StatefulWidget {
  final int userId;

  ChangePasswordPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AccountRepository _accountRepository = AccountRepository();

  Future<void> _showErrorDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 5;
  }

  Future<void> _savePasswordChanges() async {
    if (!_isValidPassword(_newPasswordController.text)) {
      _showErrorDialog("A senha deve ter mais de 5 caracteres e não pode ser vazia.");
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showErrorDialog("As senhas não coincidem.");
      return;
    }

    String? currentPassword = await _requestCurrentPassword();
    if (currentPassword == null) {
      return;
    }

    String? storedPassword = await _accountRepository.buscarSenha(widget.userId);
    if (storedPassword != currentPassword) {
      _showErrorDialog("Senha atual incorreta.");
      return;
    }

    bool passwordUpdated = await _accountRepository.alterarSenha(_newPasswordController.text, widget.userId);

    if (passwordUpdated) {
      Navigator.pop(context, true); // Retornar para a página anterior com sucesso
    } else {
      _showErrorDialog("Falha ao atualizar senha.");
    }
  }

  Future<String?> _requestCurrentPassword() async {
    String? currentPassword;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Digite sua senha atual"),
          content: TextField(
            obscureText: true,
            onChanged: (value) {
              currentPassword = value;
            },
            decoration: InputDecoration(labelText: "Senha Atual"),
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo sem salvar
              },
            ),
            TextButton(
              child: Text("Confirmar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo e salva a senha
              },
            ),
          ],
        );
      },
    );
    return currentPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mudar Senha")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Nova Senha"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Repita Nova Senha"),
            ),
            SizedBox(height: 20),
            SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
              onPressed: () {
                _savePasswordChanges;
              },
              child: Text("Alterar Senha")),
          ),
          ],
        ),
      ),
    );
  }
}