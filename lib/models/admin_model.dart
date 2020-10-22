import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AdminModel extends ChangeNotifier {
  String _username;
  String _password;
  String _name;
  DateTime _dateInsertion;
  bool _isOnline;
  CollectionReference _collectionAdmins;

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
    _collectionAdmins = FirebaseFirestore.instance.collection("admins");
    return _collectionAdmins;
  }
}
