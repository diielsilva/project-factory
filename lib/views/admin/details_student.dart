import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/models/student_model.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class DetailsStudent extends StatefulWidget {
  @override
  _DetailsStudentState createState() => _DetailsStudentState();
}

class _DetailsStudentState extends State<DetailsStudent> {
  StudentModel _studentModel = StudentModel();
  AdminController _adminController = AdminController();
  int _resultRemotion;

  @override
  void initState() {
    super.initState();
    setStudentModel();
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
      title: Text("Detalhes do Aluno"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [removeAdminButton(), addSheetToStudent()],
          )
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
          Flexible(child: Text(_studentModel.getUsername()))
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
          Flexible(child: Text(_studentModel.getName()))
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
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
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

  Widget addSheetToStudent() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Adicionar Treino"),
              FaIcon(FontAwesomeIcons.dumbbell)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            Routes().addSheet();
          },
        ),
      ),
    );
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
                Routes().successRemoveStudent();
              },
            )
          ],
        ));
  }

  Future<bool> errorStudentOnline() {
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
          await _adminController.removeStudent(_studentModel.getUsername());
      resultRemotion(_resultRemotion);
    });
  }

  void resultRemotion(int result) {
    if (result == -1) {
      errorStudentOnline();
    } else {
      successRemotion();
    }
  }

  void setStudentModel() {
    _studentModel = Provider.of<StudentModel>(context, listen: false);
  }
}
