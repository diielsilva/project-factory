import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_prototype/controllers/admin_controller.dart';
import 'package:new_prototype/controllers/login_controller.dart';
import 'package:new_prototype/models/admin_model.dart';
import 'package:new_prototype/models/student_model.dart';
import 'package:new_prototype/views/admin/add_admin.dart';
import 'package:new_prototype/views/admin/add_student.dart';
import 'package:new_prototype/views/admin/details_admin.dart';
import 'package:new_prototype/views/admin/home_admin.dart';
import 'package:new_prototype/views/admin/list_admins.dart';
import 'package:new_prototype/views/admin/list_students.dart';
import 'package:new_prototype/views/home_page.dart';
import 'package:new_prototype/views/student/home_student.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminModel>.value(value: AdminModel()),
        ChangeNotifierProvider<StudentModel>.value(value: StudentModel()),
        ChangeNotifierProvider<LoginController>.value(value: LoginController()),
        ChangeNotifierProvider<AdminController>.value(value: AdminController())
      ],
      child: GetMaterialApp(
        theme: ThemeData.dark(),
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: "/", page: () => HomePage()),
          GetPage(name: "/homeAdmin", page: () => HomeAdmin()),
          GetPage(name: "/homeStudent", page: () => HomeStudent()),
          GetPage(name: "/addAdmin", page: () => AddAdmin()),
          GetPage(name: "/addStudent", page: () => AddStudent()),
          GetPage(name: "/listAdmins", page: () => ListAdmins()),
          GetPage(name: "/listStudents", page: () => ListStudents()),
          GetPage(name: "/detailsAdmin", page: () => DetailsAdmin())
        ],
      ),
    ),
  );
}