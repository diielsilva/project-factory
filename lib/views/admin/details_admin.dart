import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/models/admin_model.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class DetailsAdmin extends StatefulWidget {
  @override
  _DetailsAdminState createState() => _DetailsAdminState();
}

class _DetailsAdminState extends State<DetailsAdmin> {
  AdminModel _adminModel;
  AdminController _adminController = AdminController();
  int _resultRemotion;

  @override
  void initState() {
    super.initState();
    setAdmin();
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
      title: Text("Detalhes do Admin"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return SingleChildScrollView(
      child: Column(
        children: [
          headerOfColumn(),
          dividerFields(),
          usernameField(),
          nameField(),
          dividerFields(),
          removeAdminButton()
        ],
      ),
    );
  }

  Widget headerOfColumn() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.userAlt, size: 80),
    );
  }

  Widget usernameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Usuário: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(_adminModel.getUsername()))
        ],
      ),
    );
  }

  Widget nameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Nome: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(_adminModel.getName()))
        ],
      ),
    );
  }

  Widget dividerFields() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Divider(
        color: Colors.white,
      ),
    );
  }

  Widget removeAdminButton() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: 150,
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Remover"), FaIcon(FontAwesomeIcons.solidTrashAlt)],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            confirmRemotion();
          },
        ),
      ),
    );
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
      _resultRemotion =
          await _adminController.removeAdmin(_adminModel.getUsername());
      resultRemotion(_resultRemotion);
    });
  }

  Future<bool> confirmRemotion() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Confirmar Remoção"),
          content: Text("Deseja Mesmo Remover o Usuário?"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () async {
                Routes().backOneRoute(true);
                await onLoading();
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
      errorAdminOnline();
    } else if (result == 0) {
      errorHasSheet();
    } else {
      successRemotion();
    }
  }

  Future<bool> errorAdminOnline() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Remoção"),
          content: Text("Usuário Atualmente em Uso"),
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

  Future<bool> errorHasSheet() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Remoção"),
          content: Text("Usuário Atualmente Vinculado a um Treino"),
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
          content: Text("Usuário Removido com Sucesso"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().successRemoveAdmin();
              },
            )
          ],
        ));
  }

  void setAdmin() {
    _adminModel = Provider.of<AdminModel>(context, listen: false);
  }
}
