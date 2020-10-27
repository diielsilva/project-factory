import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_prototype/models/student_model.dart';

class StudentController extends ChangeNotifier {
  StudentModel _studentModel = StudentModel();
  CollectionReference _database;

  Stream<QuerySnapshot> perfilStudent(String username) {
    _database = _studentModel.getConnection();
    return _database.where("username", isEqualTo: username).snapshots();
  }
}