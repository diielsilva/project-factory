import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/models/student_model.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class ListStudents extends StatefulWidget {
  @override
  _ListStudentsState createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
  TextEditingController _searchController = TextEditingController();
  Stream _stream;
  List<DocumentSnapshot> _documents;
  AdminController _adminController = AdminController();

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
      title: Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 135,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: "Inserir Nome",
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.search),
              onPressed: () {
                validateForm();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget bodyOfScaffold() {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              _documents = snapshot.data.documents;

              if (_documents.isEmpty) {
                return Center(child: Text("Nenhum Usuário Encontrado"));
              } else {
                return listOfAllStudents(_documents);
              }
          }
        });
  }

  Widget listOfAllStudents(List<DocumentSnapshot> documents) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(documents[index].get("name")),
            leading: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: FaIcon(FontAwesomeIcons.solidUser, color: Colors.white)),
            trailing: FaIcon(FontAwesomeIcons.angleRight),
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

  Future<bool> errorEmptyFields() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Pesquisa"),
          content: Text("Preencha Todos os Campos Corretamente"),
          actions: [
            FlatButton(
              child: Text("Confirmar"),
              textColor: Colors.blue,
              onPressed: () {
                Routes().backOneRoute(true);
              },
            ),
          ],
        ));
  }

  Future<bool> errorInsufficientSize() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Pesquisa"),
          content: Text("Insira ao Menos Três Caracteres por Campo"),
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

  void validateForm() {
    if (_searchController.text.isEmpty) {
      errorEmptyFields();
    } else if (_searchController.text.length < 3) {
      errorInsufficientSize();
    } else {
      StudentModel _studentModel =
          Provider.of<StudentModel>(context, listen: false);
      _studentModel.setName(_searchController.text);
    }
  }

  void setStream() {
    _stream = _adminController.listAllStudents();
  }
}
