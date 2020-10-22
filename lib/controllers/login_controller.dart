import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_prototype/models/admin_model.dart';
import 'package:new_prototype/models/student_model.dart';

class LoginController extends ChangeNotifier {
  String _typeOfUser;
  String _currentUserOnline;
  AdminModel _adminModel = AdminModel();
  StudentModel _studentModel = StudentModel();
  CollectionReference _database;
  QuerySnapshot _querySnapshot;
  String _idUser;

  void setCurrentUserOnline(String currentUserOnline) {
    _currentUserOnline = currentUserOnline;
  }

  String getCurrentUserOnline() {
    return _currentUserOnline;
  }

  void setTypeOfUser(String typeOf) {
    _typeOfUser = typeOf;
    notifyListeners();
  }

  String getTypeOfUser() {
    return _typeOfUser;
  }

  Future<int> loginUser(
      String username, String password, String typeOfUser) async {
    if (typeOfUser == "Administrador") {
      _database = _adminModel.getConnection();
      _querySnapshot = await _database
          .where("username", isEqualTo: username)
          .where("password", isEqualTo: password)
          .get();
      if (_querySnapshot.size > 0) {
        setTypeOfUser("admin");
        setUserAsOnline(_typeOfUser);
      }
      return _querySnapshot.size;
    } else {
      _database = _studentModel.getConnection();
      _querySnapshot = await _database
          .where("username", isEqualTo: username)
          .where("password", isEqualTo: password)
          .get();
      if (_querySnapshot.size > 0) {
        setTypeOfUser("student");
        setUserAsOnline(_typeOfUser);
      }
      return _querySnapshot.size;
    }
  }

  Future<void> setUserAsOnline(String typeOfUser) async {
    if (typeOfUser == "admin") {
      _database = _adminModel.getConnection();
      _querySnapshot.docs.forEach((element) {
        _idUser = element.id;
      });
      await _database.doc(_idUser).update({"online": true});
    } else {
      _database = _studentModel.getConnection();
      _querySnapshot.docs.forEach((element) {
        _idUser = element.id;
      });
      await _database.doc(_idUser).update({"online": true});
    }
  }

  Future<void> logoutUser(String username, String typeOfUser) async {
    if (typeOfUser == "admin") {
      _database = _adminModel.getConnection();
      _querySnapshot =
          await _database.where("username", isEqualTo: username).get();
      _querySnapshot.docs.forEach((element) {
        _idUser = element.id;
      });
      await _database.doc(_idUser).update({"online": false});
    } else {
      _database = _studentModel.getConnection();
      _querySnapshot =
          await _database.where("username", isEqualTo: username).get();
      _querySnapshot.docs.forEach((element) {
        _idUser = element.id;
      });
      await _database.doc(_idUser).update({"online": false});
    }
  }
}
