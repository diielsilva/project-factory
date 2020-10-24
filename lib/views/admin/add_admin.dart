import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/routes/routes.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  AdminController _adminController = AdminController();
  String _resultOfInsertion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Cadastrar Administrador"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            headerOfForm(),
            usernameField(),
            passwordField(),
            nameField(),
            addAdminButton()
          ],
        ),
      ),
    );
  }

  Widget headerOfForm() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.userPlus, size: 80),
    );
  }

  Widget usernameField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
            labelText: "Usuário",
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
            labelText: "Senha",
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget nameField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
            labelText: "Nome",
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget addAdminButton() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: 150,
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Cadastrar"), FaIcon(FontAwesomeIcons.solidSave)],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            validateForm();
          },
        ),
      ),
    );
  }

  Future<void> validateForm() async {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      errorEmptyFields();
    } else {
      await onLoading();
      resultInsertions(_resultOfInsertion);
    }
  }

  Future<void> onLoading() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Carregando", textAlign: TextAlign.center),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        ));

    await Future.delayed(Duration(seconds: 5), () async {
      Routes().backOneRoute(true);
      _resultOfInsertion = await _adminController.addAdmin(
          _usernameController.text,
          _passwordController.text,
          _nameController.text);
    });
  }

  void resultInsertions(String result) {
    if (result == "existentUser") {
      errorExistentUser();
    } else if (result == "errorSize") {
      errorInsufficientSize();
    } else {
      successInsertion();
      setState(() {
        _usernameController.text = "";
        _passwordController.text = "";
        _nameController.text = "";
      });
    }
  }

  Future<bool> successInsertion() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Cadastro Concluído"),
          content: Text("Usuário Cadastrado com Sucesso"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().backOneRoute(true);
              },
            ),
          ],
        ));
  }

  Future<bool> errorExistentUser() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro no Cadastro"),
          content: Text("Usuário Já Cadastrado"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().backOneRoute(true);
              },
            )
          ],
        ));
  }

  Future<bool> errorEmptyFields() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        child: AlertDialog(
          title: Text("Erro no Cadastro"),
          content: Text("Preencha Todos os Campos Corretamente"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().backOneRoute(true);
              },
            )
          ],
        ));
  }

  Future<bool> errorInsufficientSize() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro no Cadastro"),
          content: Text("Insira ao Menos Três Caracteres por Campo"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().backOneRoute(true);
              },
            ),
          ],
        ));
  }
}
