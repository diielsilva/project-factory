import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_prototype/views/admin/home_admin.dart';
import 'package:new_prototype/views/home_page.dart';
import 'package:new_prototype/views/student/home_student.dart';

class Routes {
  void backOneRoute(bool confirmBack) {
    if (confirmBack == true) {
      navigator.pop(true);
    } else {
      navigator.pop(false);
    }
  }

  Future<dynamic> correctHomePage(String typeOfUser) {
    if (typeOfUser == "admin") {
      return navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
        return HomeAdmin();
      }), ModalRoute.withName("/homeAdmin"));
    } else {
      return navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
        return HomeStudent();
      }), ModalRoute.withName("/homeStudent"));
    }
  }

  backToHomePage(bool confirm) {
    if (confirm == true) {
      return navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
        return HomePage();
      }), ModalRoute.withName("/"));
    } else {
      return navigator.pop(false);
    }
  }

  Future<dynamic> logoutUser() {
    return navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
      return HomePage();
    }), ModalRoute.withName("/"));
  }

  Future<dynamic> addAdmin() {
    return navigator.pushNamed("/addAdmin");
  }

  Future<dynamic> addStudent() {
    return navigator.pushNamed("/addStudent");
  }

  Future<dynamic> listAdmins() {
    return navigator.pushNamed("/listAdmins");
  }

  Future<dynamic> listStudents() {
    return navigator.pushNamed("/listStudents");
  }

  Future<dynamic> detailsAdmin() {
    return navigator.pushNamed("/detailsAdmin");
  }

  Future<dynamic> detailsStudent() {
    return navigator.pushNamed("/detailsStudent");
  }

  Future<dynamic> searchAdmins() {
    return navigator.pushNamed("/searchAdmins");
  }

  Future<dynamic> searchStudents() {
    return navigator.pushNamed("/searchStudents");
  }

  Future<dynamic> perfilAdmin() {
    return navigator.pushNamed("/perfilAdmin");
  }

  Future<dynamic> editAdmin() {
    return navigator.pushNamed("/editAdmin");
  }

  Future<dynamic> successEditionAdmin() async {
    return navigator.popUntil(ModalRoute.withName("/perfilAdmin"));
  }

  Future<dynamic> successRemoveAdmin() async {
    return navigator.popUntil(ModalRoute.withName("/listAdmins"));
  }

  Future<dynamic> successRemoveStudent() async {
    return navigator.popUntil(ModalRoute.withName("/listStudents"));
  }

  Future<dynamic> mySheets() {
    return navigator.pushNamed("/mySheets");
  }
}
