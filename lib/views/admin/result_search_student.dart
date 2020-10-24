import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/models/student_model.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class ResultSearchStudents extends StatefulWidget {
  @override
  _ResultSearchStudentsState createState() => _ResultSearchStudentsState();
}

class _ResultSearchStudentsState extends State<ResultSearchStudents> {
  AdminController _adminController = AdminController();
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
      title: Text("Resultado da Pesquisa"),
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
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.data.documents.length == 0) {
                return Center(child: Text("Nenhum Usuário Encontrado"));
              } else {
                return resultSearchStudents(snapshot.data.documents);
              }
          }
        });
  }

  Widget resultSearchStudents(List<DocumentSnapshot> documents) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(documents[index].get("name")),
            leading: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: FaIcon(FontAwesomeIcons.userAlt, color: Colors.white)),
            trailing: FaIcon(FontAwesomeIcons.angleRight, color: Colors.white),
            onTap: () {
              StudentModel _studentModel =
                  Provider.of<StudentModel>(context, listen: false);
              _studentModel.setUsername(documents[index].get("username"));
              _studentModel.setName(documents[index].get("name"));
              Routes().detailsStudent();
            },
          );
        });
  }

  void setStream() {
    StudentModel _studentModel =
        Provider.of<StudentModel>(context, listen: false);
    _stream = _adminController.searchStudents(_studentModel.getName());
  }
}
