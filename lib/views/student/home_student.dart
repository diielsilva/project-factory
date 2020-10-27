import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        body: bodyOfScaffold(),
        drawer: drawerOfScaffold(),
        bottomNavigationBar: bottomAppbar(),
      ),
      onWillPop: confirmExitSession,
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Menu do Aluno"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [mySheetButton(), myPerfilButton()],
            )
          ],
        ),
      ),
    );
  }

  Widget mySheetButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Meu Treino"),
              FaIcon(FontAwesomeIcons.dumbbell, color: Colors.white)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {},
        ),
      ),
    );
  }

  Widget myPerfilButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Meu Perfil"),
              FaIcon(FontAwesomeIcons.userCog, color: Colors.white)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            Routes().perfilStudent();
          },
        ),
      ),
    );
  }

  Widget drawerOfScaffold() {
    return Drawer(
      child: ListView(
        children: [headerOfDrawer(), logoutDrawerItem()],
      ),
    );
  }

  Widget headerOfDrawer() {
    return Container(
      height: 70,
      child: DrawerHeader(
        child: Text("Menu de Opções",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }

  Widget logoutDrawerItem() {
    return ListTile(
      title: Text("Sair"),
      trailing: FaIcon(FontAwesomeIcons.signOutAlt),
      onTap: () {
        LoginController _controller =
            Provider.of<LoginController>(context, listen: false);
        _loginController.logoutUser(
            _controller.getCurrentUserOnline(), "student");
        Routes().logoutUser();
      },
    );
  }

  Widget bottomAppbar() {
    return BottomAppBar(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Desenvolvido por DLNW Solutions",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
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
