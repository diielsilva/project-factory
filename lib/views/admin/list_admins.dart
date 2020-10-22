import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/models/admin_model.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class ListAdmins extends StatefulWidget {
  @override
  _ListAdminsState createState() => _ListAdminsState();
}

class _ListAdminsState extends State<ListAdmins> {
  AdminController _adminController = AdminController();
  Stream _stream;
  List<DocumentSnapshot> _documents;
  TextEditingController _searchController = TextEditingController();

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
            onPressed: () {},
          )
        ],
      ),
    ));
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
              return listOfAllAdmins(_documents);
          }
        });
  }

  Widget listOfAllAdmins(List<DocumentSnapshot> document) {
    return ListView.builder(
        itemCount: document.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(document[index].get("name")),
            leading: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: FaIcon(FontAwesomeIcons.solidUser, color: Colors.white)),
            trailing: FaIcon(FontAwesomeIcons.angleRight),
            onTap: () {
              AdminModel _adminModel = Provider.of<AdminModel>(context, listen: false);
              _adminModel.setUsername(document[index].get("username"));
              _adminModel.setName(document[index].get("name"));
              Routes().detailsAdmin();
            },
          );
        });
  }

  void setStream() {
    _stream = _adminController.listAllAdmins();
  }
}
