import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_prototype/models/admin_model.dart';
import 'package:new_prototype/models/student_model.dart';

class AdminController extends ChangeNotifier {
  AdminModel _adminModel = AdminModel();
  StudentModel _studentModel = StudentModel();
  CollectionReference _database;
  String _resultInsertion;
  String _idUser;
  int _validateIfUserExists;
  QuerySnapshot _querySnapshot;
  List<String> _keyWords = [];

  Future<String> addAdmin(String username, String password, String name) async {
    _validateIfUserExists = await verifyIfUserExists(username, "admin");
    if (_validateIfUserExists > 0) {
      _resultInsertion = "existentUser";
      return _resultInsertion;
    } else if (username.length < 3 || password.length < 3 || name.length < 3) {
      _resultInsertion = "errorSize";
      return _resultInsertion;
    } else {
      _database = _adminModel.getConnection();
      _adminModel.setDateInsertion();
      _keyWords = name.toLowerCase().split(" ");
      DocumentReference _idInsertion = await _database.add({
        "username": username,
        "password": password,
        "name": name,
        "online": false,
        "dateInsertion": _adminModel.getDateInsertion(),
        "keyWords": _keyWords,
      });
      _resultInsertion = _idInsertion.id;
      return _resultInsertion;
    }
  }

  Future<int> verifyIfUserExists(String username, String typeOfUser) async {
    if (typeOfUser == "admin") {
      _database = _adminModel.getConnection();
      _querySnapshot =
          await _database.where("username", isEqualTo: username).get();
      return _querySnapshot.size;
    } else {
      _database = _studentModel.getConnection();
      _querySnapshot =
          await _database.where("username", isEqualTo: username).get();
      return _querySnapshot.size;
    }
  }

  Future<String> addStudent(String username, String password, String name,
      String observations) async {
    _database = _studentModel.getConnection();
    _validateIfUserExists = await verifyIfUserExists(username, "student");

    if (_validateIfUserExists > 0) {
      _resultInsertion = "existentUser";
      return _resultInsertion;
    } else if (username.length < 3 ||
        name.length < 3 ||
        password.length < 3 ||
        observations.length < 3) {
      _resultInsertion = "errorSize";
      return _resultInsertion;
    } else {
      _database = _studentModel.getConnection();
      _studentModel.setDateInsertion();
      _keyWords = name.toLowerCase().split(" ");
      DocumentReference _idInsertion = await _database.add({
        "username": username,
        "password": password,
        "name": name,
        "dateInsertion": _studentModel.getDateInsertion(),
        "online": false,
        "keyWords": _keyWords
      });
      _resultInsertion = _idInsertion.id;
      return _resultInsertion;
    }
  }

  Stream<QuerySnapshot> listAllAdmins() {
    _database = _adminModel.getConnection();
    return _database.orderBy("name").snapshots();
  }

  Stream<QuerySnapshot> listAllStudents() {
    _database = _studentModel.getConnection();
    return _database.orderBy("name").snapshots();
  }

  Stream<QuerySnapshot> searchAdmins(String searchText) {
    _database = _adminModel.getConnection();
    return _database.where("keyWords", arrayContains: searchText).snapshots();
  }
}
