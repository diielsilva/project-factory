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
  List<dynamic> _auxListExercises = [];

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
      for (int b = 0; b < _listOfExercises.length; b++) {
        if (_listOfExercises[b]["dayOfExercise"] == _dayOfExercise) {
          Map<dynamic, dynamic> map = {
            "dayOfExercise": _listOfExercises[b]["dayOfExercise"],
            "muscularGroup": _listOfExercises[b]["muscularGroup"],
            "nameExercise": _listOfExercises[b]["nameExercise"],
            "repetitions": _listOfExercises[b]["repetitions"],
            "series": _listOfExercises[b]["series"]
          };
          _auxListExercises.add(map);
        }
      }

      if (_auxListExercises == null) {
        return Center(child: Text("Nenhum Exercício Encontrado"));
      } else {
        return ListView.builder(
            itemCount: _auxListExercises.length,
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
                        Text(_auxListExercises[index]["nameExercise"])
                      ]),
                      Row(
                        children: [
                          Text(
                            "GP. Muscular: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_auxListExercises[index]["muscularGroup"])
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Nº Séries: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_auxListExercises[index]["series"].toString())
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Nº Repetições: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_auxListExercises[index]["repetitions"]
                              .toString())
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Dia do Exercício: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_auxListExercises[index]["dayOfExercise"])
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
