import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_prototype/models/admin_model.dart';
import 'package:new_prototype/models/sheet_model.dart';
import 'package:new_prototype/models/student_model.dart';

class AdminController extends ChangeNotifier {
  AdminModel _adminModel = AdminModel();
  StudentModel _studentModel = StudentModel();
  CollectionReference _database;
  String _resultInsertion;
  String _idUser;
  String _idSheet;
  int _validateIfUserExists;
  QuerySnapshot _querySnapshot;
  List<String> _keyWords = [];
  SheetModel _sheetModel = SheetModel();
  bool _isAdminOnline;
  bool _isStudentOnline;

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
    return _database
        .where("keyWords", arrayContains: searchText.toLowerCase())
        .snapshots();
  }

  Stream<QuerySnapshot> searchStudents(String searchText) {
    _database = _studentModel.getConnection();
    return _database
        .where("keyWords", arrayContains: searchText.toLowerCase())
        .snapshots();
  }

  Stream<QuerySnapshot> perfilAdmin(String username) {
    _database = _adminModel.getConnection();
    return _database.where("username", isEqualTo: username).snapshots();
  }

  Future<int> editAdmin(String username, String password, String name) async {
    _database = _adminModel.getConnection();
    if (password.isNotEmpty && password.length < 3 ||
        name.isNotEmpty && name.length < 3) {
      return 0;
    } else {
      _querySnapshot =
      await _database.where("username", isEqualTo: username).get();
      if (password.isEmpty && name.isNotEmpty) {
        _querySnapshot.docs.forEach((element) {
          _idUser = element.id;
        });
        await _database.doc(_idUser).update({"name": name});
        return 1;
      } else if (password.isNotEmpty && name.isEmpty) {
        _querySnapshot.docs.forEach((element) {
          _idUser = element.id;
        });
        await _database.doc(_idUser).update({"password": password});
        return 1;
      } else {
        _querySnapshot.docs.forEach((element) {
          _idUser = element.id;
        });
        await _database
            .doc(_idUser)
            .update({"password": password, "name": name});
        return 1;
      }
    }
  }

  Future<int> removeAdmin(String username) async {
    _database = _adminModel.getConnection();
    _querySnapshot =
    await _database.where("username", isEqualTo: username).get();
    _querySnapshot.docs.forEach((element) {
      _isAdminOnline = element.get("online");
      _idUser = element.id;
    });
    if (_isAdminOnline == true) {
      return -1;
    } else {
      _database = _sheetModel.getConnection();
      _querySnapshot =
      await _database.where("sheetBy", isEqualTo: username).get();
      if (_querySnapshot.size > 0) {
        return 0;
      } else {
        _database = _adminModel.getConnection();
        await _database.doc(_idUser).delete();
        return 1;
      }
    }
  }

  Future<int> removeStudent(String username) async {
    _database = _studentModel.getConnection();
    _querySnapshot =
    await _database.where("username", isEqualTo: username).get();
    _querySnapshot.docs.forEach((element) {
      _idUser = element.id;
      _isStudentOnline = element.get("online");
    });
    if (_isStudentOnline == true) {
      return -1;
    } else {
      _database = _sheetModel.getConnection();
      _querySnapshot =
      await _database.where("studentUsername", isEqualTo: username).get();
      if (_querySnapshot.size > 0) {
        _querySnapshot.docs.forEach((element) {
          _idSheet = element.id;
        });
        await _database.doc(_idSheet).delete();
        _database = _studentModel.getConnection();
        await _database.doc(_idUser).delete();
        return 0;
      } else {
        _database = _studentModel.getConnection();
        await _database.doc(_idUser).delete();
        return 1;
      }
    }
  }

  Stream<QuerySnapshot> mySheets(String username) {
    _database = _sheetModel.getConnection();
    return _database.where("sheetBy", isEqualTo: username).snapshots();
  }

  Future<int> removeSheetAdmin(String usernameAdmin,
      String usernameStudent) async {
    _database = _studentModel.getConnection();
    _querySnapshot =
    await _database.where("username", isEqualTo: usernameStudent).get();
    _querySnapshot.docs.forEach((element) {
      _isStudentOnline = element.get("online");
    });
    if (_isStudentOnline == true) {
      return -1;
    }
    else {
      _database = _sheetModel.getConnection();
      _querySnapshot =
      await _database.where("sheetBy", isEqualTo: usernameAdmin).where(
          "studentUsername", isEqualTo: usernameStudent).get();
      _querySnapshot.docs.forEach((element) {
        _idSheet = element.id;
      });
      await _database.doc(_idSheet).delete();
      return 0;
    }
  }
}
