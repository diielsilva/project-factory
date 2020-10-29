import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StudentModel extends ChangeNotifier {
  String _username;
  String _password;
  String _name;
  String _observations;
  String _dayOfTraining;
  DateTime _dateInsertion;
  bool _isOnline;
  CollectionReference _collectionStudents;

  void setDayOfTraining(String day) {
    _dayOfTraining = day;
    notifyListeners();
  }

  String getDayOfTraining() {
    return _dayOfTraining;
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  String getUsername() {
    return _username;
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String getPassword() {
    return _password;
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  String getName() {
    return _name;
  }

  void setObservations(String observations) {
    _observations = observations;
    notifyListeners();
  }

  String getObservations() {
    return _observations;
  }

  void setDateInsertion() {
    _dateInsertion = DateTime.now();
    notifyListeners();
  }

  DateTime getDateInsertion() {
    return _dateInsertion;
  }

  void setIsOnline(bool isOnline) {
    _isOnline = isOnline;
    notifyListeners();
  }

  bool getIsOnline() {
    return _isOnline;
  }

  CollectionReference getConnection() {
    _collectionStudents = FirebaseFirestore.instance.collection("students");
    return _collectionStudents;
  }
}
