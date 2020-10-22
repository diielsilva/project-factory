import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/models/admin_model.dart';
import 'package:provider/provider.dart';

class DetailsAdmin extends StatefulWidget {
  @override
  _DetailsAdminState createState() => _DetailsAdminState();
}

class _DetailsAdminState extends State<DetailsAdmin> {
  AdminModel _adminModel;

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
          usernameField(),
          nameField(),
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
        children: [
          Text("Nome: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(_adminModel.getName()))
        ],
      ),
    );
  }

  void setAdmin() {
    _adminModel = Provider.of<AdminModel>(context, listen: false);
  }
}
