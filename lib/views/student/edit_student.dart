import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditStudent extends StatefulWidget {
  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Editar Aluno"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            headerOfForm(),
            passwordField(),
            nameField(),
            editStudentButton()
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

  Widget editStudentButton() {
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
          },
        ),
      ),
    );
  }
}
