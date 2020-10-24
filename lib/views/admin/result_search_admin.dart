import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/models/admin_model.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class ResultSearchAdmins extends StatefulWidget {
  @override
  _ResultSearchAdminsState createState() => _ResultSearchAdminsState();
}

class _ResultSearchAdminsState extends State<ResultSearchAdmins> {
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
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.data.documents.length == 0) {
                return Center(child: Text("Nenhum Usuário Encontrado"));
              } else {
                return resultSearchAdmins(snapshot.data.documents);
              }
          }
        });
  }

  Widget resultSearchAdmins(List<DocumentSnapshot> documents) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(documents[index].get("name")),
            leading: CircleAvatar(
                child: FaIcon(FontAwesomeIcons.userAlt, color: Colors.white),
                backgroundColor: Colors.deepOrange),
            trailing: FaIcon(FontAwesomeIcons.angleRight),
            onTap: () {
              AdminModel _adminModel =
                  Provider.of<AdminModel>(context, listen: false);
              _adminModel.setName(documents[index]["name"]);
              _adminModel.setUsername(documents[index]["username"]);
              Routes().detailsAdmin();
            },
          );
        });
  }

  void setStream() {
    AdminModel _adminModel = Provider.of<AdminModel>(context, listen: false);
   _stream = _adminController.searchAdmins(_adminModel.getName());
  }
}
