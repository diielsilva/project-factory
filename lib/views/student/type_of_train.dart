import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/controllers/student_controller.dart';
import 'package:new_prototype/models/student_model.dart';
import 'package:provider/provider.dart';

class TypeOfTrain extends StatefulWidget {
  @override
  _TypeOfTrainState createState() => _TypeOfTrainState();
}

class _TypeOfTrainState extends State<TypeOfTrain> {
  StudentController _studentController = StudentController();
  Stream<QuerySnapshot> _stream;
  List<dynamic> _listOfExercises;
  String _dayOfExercise;

  @override
  void initState() {
    super.initState();
    setDocuments();
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
      title: Text("Lista de Exercícios"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return controlList();
  }

  Widget controlList() {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.none:
            return Center(child: CircularProgressIndicator());
          default:
            return returnListViewExercises(snapshot.data.documents);
        }
      },
    );
  }

  Widget returnListViewExercises(List<DocumentSnapshot> document) {
    document.forEach((element) {
      _listOfExercises = element.get("exercisesList");
    });
    if (_listOfExercises == null) {
      return Center(child: Text("Nenhum Exercício Encontrado"));
    } else {
      for (int a = 0; a <= _listOfExercises.length; a++) {
        for (int b = 0; b < _listOfExercises.length; b++) {
          if (_listOfExercises[b]["dayOfExercise"] != _dayOfExercise && _listOfExercises.length > 1) {
            _listOfExercises.removeAt(b);
          }
        }
      }

      if (_listOfExercises.length == 1 &&
          _listOfExercises[0]["dayOfExercise"] != _dayOfExercise) {
        _listOfExercises = null;
        return Center(child: Text("Nenhum Exercício Encontrado"));
      } else {
        return ListView.builder(
            itemCount: _listOfExercises.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        child: FaIcon(
                          FontAwesomeIcons.dumbbell,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  title: Column(
                    children: [
                      Row(children: [
                        Text(
                          "Exercício: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(_listOfExercises[index]["nameExercise"])
                      ]),
                      Row(
                        children: [
                          Text(
                            "GP. Muscular: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_listOfExercises[index]["muscularGroup"])
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Nº Séries: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_listOfExercises[index]["series"].toString())
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Nº Repetições: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              _listOfExercises[index]["repetitions"].toString())
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Dia do Exercício: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_listOfExercises[index]["dayOfExercise"])
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      }
    }
  }

  void setDocuments() {
    LoginController _loginController =
        Provider.of<LoginController>(context, listen: false);
    StudentModel _studentModel =
        Provider.of<StudentModel>(context, listen: false);
    _dayOfExercise = _studentModel.getDayOfTraining();
    _stream = _studentController
        .getExercisesOfSelectedStudent(_loginController.getCurrentUserOnline());
  }
}
