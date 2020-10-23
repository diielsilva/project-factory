import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  int _resultOfLogin;
  String _selectedTypeOfUser;
  List<String> _listTypeOfUser = ["Administrador", "Aluno"];
  LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Sheet - Meu Treino"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return SingleChildScrollView(
      child: Form(
        onWillPop: confirmExitApp,
        child: Column(
          children: [
            headerOfColumn(),
            usernameField(),
            passwordField(),
            listOfTypeOfUser(),
            loginButton()
          ],
        ),
      ),
    );
  }

  Widget headerOfColumn() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 60, 10, 60),
      child: Image.asset("images/logo_app.png"),
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
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget listOfTypeOfUser() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: SizedBox(
        width: 200,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              labelText: "Tipo de Usuário (a)",
              labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          items: _listTypeOfUser.map((String selectItem) {
            return DropdownMenuItem(
              value: selectItem,
              child: Text(selectItem),
            );
          }).toList(),
          value: _selectedTypeOfUser,
          onChanged: (String selectedItem) {
            setState(() {
              _selectedTypeOfUser = selectedItem;
            });
          },
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: 150,
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Entrar", style: TextStyle(color: Colors.white)),
              FaIcon(FontAwesomeIcons.signInAlt, color: Colors.white)
            ],
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
        _selectedTypeOfUser == null) {
      errorEmptyFields();
    } else {
      await onLoading();
      resultOfLogin(_resultOfLogin);
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
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ));

    await Future.delayed(Duration(seconds: 5), () async {
      Routes().backOneRoute(true);
      _resultOfLogin = await _loginController.loginUser(
          _usernameController.text,
          _passwordController.text,
          _selectedTypeOfUser);
    });
  }

  void resultOfLogin(int resultLogin) {
    if (resultLogin == 0) {
      errorWrongFields();
    } else {
      LoginController _controller =
          Provider.of<LoginController>(context, listen: false);
      _controller.setCurrentUserOnline(_usernameController.text);
      Routes().correctHomePage(_loginController.getTypeOfUser());
    }
  }

  Future<bool> errorWrongFields() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro no Login"),
          content: Text("Usuário ou Senha Incorreto (a)"),
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

  Future<bool> errorEmptyFields() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro no Login"),
          content: Text("Preencha Todos os Campos Corretamente"),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Routes().backOneRoute(true);
              },
            )
          ],
        ));
  }

  Future<bool> confirmExitApp() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Encerrar Aplicação"),
          content: Text("Deseja Mesmo Sair do Aplicativo?"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().backOneRoute(true);
              },
            ),
            FlatButton(
              child: Text("Cancelar"),
              textColor: Colors.red,
              onPressed: () {
                Routes().backOneRoute(false);
              },
            )
          ],
        ));
  }
}
