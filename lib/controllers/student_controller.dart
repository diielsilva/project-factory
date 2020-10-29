import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_prototype/models/sheet_model.dart';
import 'package:new_prototype/models/student_model.dart';

class StudentController extends ChangeNotifier {
  SheetModel _sheetModel = SheetModel();
  StudentModel _studentModel = StudentModel();
  CollectionReference _database;
  QuerySnapshot _querySnapshot;
  String _idUser;

  Stream<QuerySnapshot> perfilStudent(String username) {
    _database = _studentModel.getConnection();
    return _database.where("username", isEqualTo: username).snapshots();
  }

  Future<int> editStudent(String username, String password, String name) async {
    if (name.isNotEmpty && name.length < 3 ||
        password.isNotEmpty && password.length < 3) {
      return 0;
    }
    else{
      _database = _studentModel.getConnection();
      _querySnapshot = await _database.where("username", isEqualTo: username).get();
      _querySnapshot.docs.forEach((element) {
        _idUser = element.id;
      });
      if(password.isEmpty && name.isNotEmpty) {
        await _database.doc(_idUser).update({
          "name": name
        });
        return 1;
      }
      else if(password.isNotEmpty && name.isEmpty) {
        await _database.doc(_idUser).update({
          "password": password
        });
        return 1;
      }
      else{
        await _database.doc(_idUser).update({
          "name": name,
          "password": password
        });
        return 1;
      }
    }
  }

  Stream<QuerySnapshot> getExercisesOfSelectedStudent(String username) {
    _database = _sheetModel.getConnection();
    return _database.where("studentUsername", isEqualTo: username).snapshots();
  }
}
