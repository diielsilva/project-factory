import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class MySheets extends StatefulWidget {
  @override
  _MySheetsState createState() => _MySheetsState();
}

class _MySheetsState extends State<MySheets> {
  AdminController _adminController = AdminController();
  Stream _stream;
  int _resultRemotion;
  String _currentUserOnline;

  @override
  void initState() {
    super.initState();
    setStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Minhas Fichas"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.data.documents.length == 0) {
                return Center(child: Text("Nenhuma Ficha Encontrada"));
              } else {
                return listOfSheets(snapshot.data.documents);
              }
          }
        });
  }

  Widget listOfSheets(List<DocumentSnapshot> documents) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Text("ID do Aluno: "),
                Text(documents[index].get("studentUsername"))
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child:
                  FaIcon(FontAwesomeIcons.clipboardList, color: Colors.white),
            ),
            trailing: IconButton(
                icon: FaIcon(FontAwesomeIcons.solidTrashAlt),
                onPressed: () {
                  validateForm(_currentUserOnline,
                      documents[index].get("studentUsername"));
                }),
          );
        });
  }

  Future<void> onLoading(String usernameAdmin, String usernameStudent) async {
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
      _resultRemotion = await _adminController.removeSheetAdmin(
          usernameAdmin, usernameStudent);
      resultRemotion(_resultRemotion);
    });
  }

  Future<void> validateForm(String usernameAdmin, String usernameStudent) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Confirmar Exclusão"),
          content: Text("Deseja Mesmo Excluir a Ficha?"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().backOneRoute(true);
                onLoading(usernameAdmin, usernameStudent);
              },
            ),
            FlatButton(
              child: Text("Cancelar"),
              textColor: Colors.red,
              onPressed: () {
                Routes().backOneRoute(true);
              },
            )
          ],
        ));
  }

  void resultRemotion(int result) {
    if (result == -1) {
      errorStudentOnline();
    } else {
      successRemotion();
    }
  }

  Future<bool> errorStudentOnline() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Remoção"),
          content: Text("Ficha Atualmente em Uso"),
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

  Future<bool> successRemotion() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Remoção Concluída"),
          content: Text("Ficha Removida com Sucesso"),
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

  void setStream() {
    LoginController _controller =
        Provider.of<LoginController>(context, listen: false);
    _currentUserOnline = _controller.getCurrentUserOnline();
    _stream = _adminController.mySheets(_currentUserOnline);
  }
}
