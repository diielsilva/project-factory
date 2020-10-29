import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:provider/provider.dart';

class ExercisesList extends StatefulWidget {
  @override
  _ExercisesListState createState() => _ExercisesListState();
}

class _ExercisesListState extends State<ExercisesList> {
  List<dynamic> _exercises;

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
    AdminController _controller =
        Provider.of<AdminController>(context, listen: false);
    _exercises = _controller.getAuxExercisesList();

    if (_exercises.isEmpty) {
      return Center(child: Text("Nenhum Exercício Encontrado"));
    } else {
      return ListView.builder(
          itemCount: _exercises.length,
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
                      Text(_exercises[index]["nameExercise"])
                    ]),
                    Row(
                      children: [
                        Text(
                          "GP. Muscular: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(_exercises[index]["muscularGroup"])
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Nº Séries: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(_exercises[index]["series"].toString())
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Nº Repetições: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(_exercises[index]["repetitions"].toString())
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Dia do Exercício: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(_exercises[index]["dayOfExercise"])
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
