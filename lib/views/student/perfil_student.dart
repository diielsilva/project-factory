import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/controllers/student_controller.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class PerfilStudent extends StatefulWidget {
  @override
  _PerfilStudentState createState() => _PerfilStudentState();
}

class _PerfilStudentState extends State<PerfilStudent> {
  StudentController _studentController = StudentController();
  Stream _stream;

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
      title: Text("Meu Perfil"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return perfilStudent(snapshot.data.documents);
          }
        },
      ),
    );
  }

  Widget perfilStudent(List<DocumentSnapshot> document) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        headerOfColumn(),
        dividerFields(),
        usernameField(document[0].get("username")),
        nameField(document[0].get("name")),
        dividerFields(),
        editStudentButton()
      ],
    );
  }

  Widget dividerFields() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Divider(color: Colors.white),
    );
  }

  Widget headerOfColumn() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.userCog, size: 80, color: Colors.white),
    );
  }

  Widget usernameField(String username) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Usuário: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(username))
        ],
      ),
    );
  }

  Widget nameField(String name) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Nome: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(name))
        ],
      ),
    );
  }

  Widget editStudentButton() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: 150,
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Editar"), FaIcon(FontAwesomeIcons.userEdit)],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            Routes().edtiStudent();
          },
        ),
      ),
    );
  }

  void setStream() {
    LoginController _controller =
        Provider.of<LoginController>(context, listen: false);
    _stream =
        _studentController.perfilStudent(_controller.getCurrentUserOnline());
  }
}
