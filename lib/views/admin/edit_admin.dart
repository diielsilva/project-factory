import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class EditAdmin extends StatefulWidget {
  @override
  _EditAdminState createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  AdminController _adminController = AdminController();
  int _resultEdition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Editar Administrador"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            headerOfForm(),
            nameField(),
            passwordField(),
            editAdminButton()
          ],
        ),
      ),
    );
  }

  Widget headerOfForm() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.userEdit, size: 80),
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

  Widget editAdminButton() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: 150,
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Editar"), FaIcon(FontAwesomeIcons.solidSave)],
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
    if (_nameController.text.isEmpty && _passwordController.text.isEmpty) {
      errorEmptyFields();
    } else {
      await onLoading();
      resultOfEdition(_resultEdition);
    }
  }

  void resultOfEdition(int result) {
    if (result == 0) {
      errorInsufficientSize();
    } else {
      successEdition();
    }
  }

  Future<void> onLoading() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Carregando", textAlign: TextAlign.center),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [CircularProgressIndicator()],
          ),
        ));

    await Future.delayed(Duration(seconds: 5), () async {
      Routes().backOneRoute(true);
      LoginController _controller =
          Provider.of<LoginController>(context, listen: false);
      _resultEdition = await _adminController.editAdmin(
          _controller.getCurrentUserOnline(),
          _passwordController.text,
          _nameController.text);
    });
  }

  Future<bool> errorEmptyFields() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Edição"),
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
          title: Text("Erro na Edição"),
          content: Text("Insira ao Menos Três Caracteres por Campo"),
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

  Future<bool> successEdition() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Sucesso na Edição"),
          content: Text("Usuário Editado com Sucesso"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().successEditionAdmin();
              },
            )
          ],
        ));
  }
}
