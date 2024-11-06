import 'package:bbc/changepassword.dart';
import 'package:bbc/class/account.dart';
import 'package:bbc/repository/accountRepository.dart';
import 'package:flutter/material.dart';


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
      appBar: AppBar(title: Text("Editar Perfil")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfileChanges,
              child: Text("Salvar Alterações"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordPage(userId: widget.account.id),
                  ),
                );
              },
              child: Text("Mudar Senha"),
            ),
          ],
        ),
      ),
    );
  }
}
