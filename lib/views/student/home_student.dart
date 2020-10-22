import 'package:flutter/material.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeStudent extends StatefulWidget {
  @override
  _HomeStudentState createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: headerOfScaffold(),
      ),
      onWillPop: confirmExitSession,
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Sheet - Meu Treino (STUDENT)"),
      centerTitle: true,
    );
  }

  Future<bool> confirmExitSession() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Encerrar Sessão"),
          content: Text("Deseja Mesmo Encerrar a Sessão?"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().backToHomePage(true);
                LoginController _controller =
                    Provider.of<LoginController>(context, listen: false);
                _loginController.logoutUser(
                    _controller.getCurrentUserOnline(), "student");
              },
            ),
            FlatButton(
              child: Text("Cancelar"),
              textColor: Colors.red,
              onPressed: () {
                Routes().backToHomePage(false);
              },
            )
          ],
        ));
  }
}
