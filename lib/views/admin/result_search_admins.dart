import 'package:flutter/material.dart';

class ResultSearchAdmins extends StatefulWidget {
  @override
  _ResultSearchAdminsState createState() => _ResultSearchAdminsState();
}

class _ResultSearchAdminsState extends State<ResultSearchAdmins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Resultado da Pesquisa"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    
  }
}
