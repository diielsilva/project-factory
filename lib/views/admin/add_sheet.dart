import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/models/student_model.dart';
import 'package:new_prototype/routes/routes.dart';
import 'package:provider/provider.dart';

class AddSheet extends StatefulWidget {
  @override
  _AddSheetState createState() => _AddSheetState();
}

class _AddSheetState extends State<AddSheet> {
  AdminController _adminController = AdminController();
  TextEditingController _nameExercise = TextEditingController();
  TextEditingController _seriesController = TextEditingController();
  TextEditingController _repetitionsController = TextEditingController();
  List<String> _dayOfExercise = ["A", "B", "C", "D"];
  List<String> _muscularGroup = [
    "Peito",
    "Ombro",
    "Tríceps",
    "Trapézio",
    "Costas",
    "Bíceps",
    "Antebraço",
    "Perna",
    "Panturrilha",
    "Abdômen"
  ];
  String _selectedMuscularGroup;
  String _selectedDay;
  int _resultAddToExerciseList;
  int _resultResetExerciseList;
  int _resultSaveExerciseList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Adicionar Treino"),
      centerTitle: true,
    );
  }

  Widget bodyOfScaffold() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            headerOfColumn(),
            nameField(),
            seriesName(),
            repetitionsField(),
            muscularGroup(),
            daysOfExercise(),
            Divider(color: Colors.transparent),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [addListButton(), seeListButton()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [resetListButton(), saveListButton()],
            )
          ],
        ),
      ),
    );
  }

  Widget headerOfColumn() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.dumbbell, color: Colors.white, size: 80),
    );
  }

  Widget nameField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        controller: _nameExercise,
        decoration: InputDecoration(
            labelText: "Nome do Exercício",
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget seriesName() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        controller: _seriesController,
        decoration: InputDecoration(
            labelText: "Número de Series",
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget repetitionsField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        controller: _repetitionsController,
        decoration: InputDecoration(
            labelText: "Número de Repetições",
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget daysOfExercise() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: SizedBox(
        width: 200,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              labelText: "Dia do Exercício",
              labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          items: _dayOfExercise.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          value: _selectedDay,
          onChanged: (String item) {
            setState(() {
              _selectedDay = item;
            });
          },
        ),
      ),
    );
  }

  Widget muscularGroup() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: SizedBox(
        width: 200,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              labelText: "Grupo Muscular",
              labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          value: _selectedMuscularGroup,
          items: _muscularGroup.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String item) {
            setState(() {
              _selectedMuscularGroup = item;
            });
          },
        ),
      ),
    );
  }

  Widget addListButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Adc. Exercício"),
              FaIcon(FontAwesomeIcons.notesMedical, color: Colors.white)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            validateAddToExercisesList();
          },
        ),
      ),
    );
  }

  Widget seeListButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Ver Exercícios"),
              FaIcon(FontAwesomeIcons.clipboardList, color: Colors.white)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            AdminController _controller =
                Provider.of<AdminController>(context, listen: false);
            _controller.setAuxExerciseList(_adminController.getExercisesList());
            Routes().seeExercisesList();
          },
        ),
      ),
    );
  }

  Widget resetListButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Resetar Lista"),
              FaIcon(FontAwesomeIcons.redo, color: Colors.white)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            validateResetExercisesList();
          },
        ),
      ),
    );
  }

  Widget saveListButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 140,
        height: 70,
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Salvar Lista"),
              FaIcon(FontAwesomeIcons.solidSave, color: Colors.white)
            ],
          ),
          color: Colors.deepOrange,
          onPressed: () {
            validateSaveExercisesList();
          },
        ),
      ),
    );
  }

  void validateAddToExercisesList() {
    if (_nameExercise.text.isEmpty ||
        _seriesController.text.isEmpty ||
        _repetitionsController.text.isEmpty ||
        _selectedDay == null ||
        _selectedMuscularGroup == null) {
      errorEmptyFields();
    } else {
      _resultAddToExerciseList = _adminController.addToExercisesList(
          _nameExercise.text,
          int.parse(_seriesController.text),
          _repetitionsController.text,
          _selectedMuscularGroup,
          _selectedDay);
      resultAddToExercisesList(_resultAddToExerciseList);
    }
  }

  void resultAddToExercisesList(int result) {
    if (result == -1) {
      errorInsufficientSize();
    } else if (result == 0) {
      errorIncorrectFields();
    } else {
      successAddedToList();
      setState(() {
        _nameExercise.text = "";
        _repetitionsController.text = "";
        _seriesController.text = "";
        _selectedMuscularGroup = null;
        _selectedDay = null;
      });
    }
  }

  Future<bool> errorEmptyFields() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Adição"),
          content: Text("Preencha Todos os Campos Corretamente"),
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

  Future<bool> errorInsufficientSize() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Adição"),
          content: Text("O Campo NOME Deve Possuir Mais Que Três Caracteres"),
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

  Future<bool> errorIncorrectFields() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro na Adição"),
          content: Text("Os Campos Devem Ter Valores Maiores que Zero"),
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

  Future<bool> successAddedToList() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Adição Concluída"),
          content: Text("Exercício Adicionado a Lista"),
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

  void validateResetExercisesList() {
    _resultResetExerciseList = _adminController.resetExercisesList();
    resultResetExercisesList(_resultResetExerciseList);
  }

  void resultResetExercisesList(int result) {
    if (result == 0) {
      errorEmptyList();
    } else {
      successResetList();
    }
  }

  Future<bool> errorEmptyList() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro ao Resetar"),
          content: Text("Impossível Resetar, Lista Vazia"),
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

  Future<bool> successResetList() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Lista Resetada"),
          content: Text("Lista Resetada com Sucesso"),
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

  Future<void> validateSaveExercisesList() async {
    await onLoading();
    resultSaveExercisesList(_resultSaveExerciseList);
  }

  Future<void> onLoading() async {
    showDialog(context: context, barrierDismissible: false, child: AlertDialog(
      title: Text("Carregando", textAlign: TextAlign.center),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [CircularProgressIndicator()],
      ),
    ));

    await Future.delayed(Duration(seconds: 5), () async {
      Routes().backOneRoute(true);
      StudentModel _studentModel =
      Provider.of<StudentModel>(context, listen: false);
      LoginController _loginController =
      Provider.of<LoginController>(context, listen: false);
      _resultSaveExerciseList = await _adminController.saveSheetDatabase(
          _loginController.getCurrentUserOnline(),
          _studentModel.getUsername(),
          _adminController.getExercisesList());
    });

  }

  void resultSaveExercisesList(int result) {
    if (result == 0) {
      errorSavedEmptyList();
    } else {
      successSavedList();
    }
  }

  Future<bool> errorSavedEmptyList() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Erro ao Salvar"),
          content: Text("Lista de Exercícios Vazia, Impossível Salvar"),
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

  Future<bool> successSavedList() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Exercícios Salvos"),
          content: Text("Ficha de Exercícios Vinculada com Sucesso"),
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
}
