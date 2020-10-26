import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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
        onWillPop: confirmExitSession);
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Menu do Administrador"),
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
              children: [addAdminButton(), addStudentButton()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [listAllAdmins(), listAllStudents()],
            )
          ],
        ),
      ),
    );
  }

  Widget addAdminButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Cadastrar Admin"),
              FaIcon(FontAwesomeIcons.userPlus)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            Routes().addAdmin();
          },
        ),
      ),
    );
  }

  Widget addStudentButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Cadastrar Aluno"),
              FaIcon(FontAwesomeIcons.userPlus)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            Routes().addStudent();
          },
        ),
      ),
    );
  }

  Widget listAllAdmins() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Listar Admins"), FaIcon(FontAwesomeIcons.users)],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            Routes().listAdmins();
          },
        ),
      ),
    );
  }

  Widget listAllStudents() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Listar Alunos"), FaIcon(FontAwesomeIcons.users)],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            Routes().listStudents();
          },
        ),
      ),
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

  Widget drawerOfScaffold() {
    return Drawer(
      child: ListView(
        children: [
          headerOfDrawer(),
          mySheets(),
          perfilAdmin(),
          logoutDrawerItem()
        ],
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

  Widget mySheets() {
    return ListTile(
      title: Text("Minhas Fichas"),
      trailing: FaIcon(FontAwesomeIcons.clipboardList),
      onTap: () {
        Routes().mySheets();
      },
    );
  }

  Widget perfilAdmin() {
    return ListTile(
      title: Text("Meu Perfil"),
      trailing: FaIcon(FontAwesomeIcons.userCog),
      onTap: () {
        Routes().perfilAdmin();
      },
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
            _controller.getCurrentUserOnline(), "admin");
        Routes().logoutUser();
      },
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
                    _controller.getCurrentUserOnline(), "admin");
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
