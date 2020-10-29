import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/models/sheet_model.dart';
import 'package:new_prototype/models/student_model.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class GroupList extends StatefulWidget {
  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Tipos de Treino"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return ListView(
      children: [dayA(), dayB(), dayC(), dayD()],
    );
  }

  Widget dayA() {
    return ListTile(
      title: Text("Treino A"),
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange,
        child: FaIcon(FontAwesomeIcons.dumbbell, color: Colors.white),
      ),
      trailing: FaIcon(FontAwesomeIcons.angleRight, color: Colors.white),
      onTap: () {
        StudentModel _studentModel =
            Provider.of<StudentModel>(context, listen: false);
        _studentModel.setDayOfTraining("A");
        Routes().typeOfWorkout();
      },
    );
  }

  Widget dayB() {
    return ListTile(
      title: Text("Treino B"),
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange,
        child: FaIcon(FontAwesomeIcons.dumbbell, color: Colors.white),
      ),
      trailing: FaIcon(FontAwesomeIcons.angleRight, color: Colors.white),
      onTap: () {
        StudentModel _studentModel =
            Provider.of<StudentModel>(context, listen: false);
        _studentModel.setDayOfTraining("B");
        Routes().typeOfWorkout();
      },
    );
  }

  Widget dayC() {
    return ListTile(
      title: Text("Treino C"),
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange,
        child: FaIcon(FontAwesomeIcons.dumbbell, color: Colors.white),
      ),
      trailing: FaIcon(FontAwesomeIcons.angleRight, color: Colors.white),
      onTap: () {
        StudentModel _studentModel =
            Provider.of<StudentModel>(context, listen: false);
        _studentModel.setDayOfTraining("C");
        Routes().typeOfWorkout();
      },
    );
  }

  Widget dayD() {
    return ListTile(
      title: Text("Treino D"),
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange,
        child: FaIcon(FontAwesomeIcons.dumbbell, color: Colors.white),
      ),
      trailing: FaIcon(FontAwesomeIcons.angleRight, color: Colors.white),
      onTap: () {
        StudentModel _studentModel =
            Provider.of<StudentModel>(context, listen: false);
        _studentModel.setDayOfTraining("D");
        Routes().typeOfWorkout();
      },
    );
  }
}
