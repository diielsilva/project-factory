import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/models/student_model.dart';
import 'package:provider/provider.dart';

class DetailsStudent extends StatefulWidget {
  @override
  _DetailsStudentState createState() => _DetailsStudentState();
}

class _DetailsStudentState extends State<DetailsStudent> {
  StudentModel _studentModel = StudentModel();

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
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: 150,
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Remover"), FaIcon(FontAwesomeIcons.solidTrashAlt)],
          ),
          color: Colors.deepOrange,
          onPressed: () {},
        ),
      ),
    );
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
              onPressed: () {},
            ),
            FlatButton(
              child: Text("Cancelar"),
              textColor: Colors.red,
              onPressed: () {},
            )
          ],
        ));
  }

  void setStudentModel() {
    _studentModel = Provider.of<StudentModel>(context, listen: false);
  }
}
