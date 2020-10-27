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
import 'package:new_prototype/views/admin/details_student.dart';
import 'package:new_prototype/views/admin/edit_admin.dart';
import 'package:new_prototype/views/admin/home_admin.dart';
import 'package:new_prototype/views/admin/list_admins.dart';
import 'package:new_prototype/views/admin/list_students.dart';
import 'package:new_prototype/views/admin/my_sheets.dart';
import 'package:new_prototype/views/admin/perfil_admin.dart';
import 'package:new_prototype/views/admin/result_search_admin.dart';
import 'package:new_prototype/views/admin/result_search_student.dart';
import 'package:new_prototype/views/home_page.dart';
import 'package:new_prototype/views/student/edit_student.dart';
import 'package:new_prototype/views/student/home_student.dart';
import 'package:new_prototype/views/student/perfil_student.dart';
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
          GetPage(name: "/detailsAdmin", page: () => DetailsAdmin()),
          GetPage(name: "/detailsStudent", page: () => DetailsStudent()),
          GetPage(name: "/searchAdmins", page: () => ResultSearchAdmins()),
          GetPage(name: "/searchStudents", page: () => ResultSearchStudents()),
          GetPage(name: "/perfilAdmin", page: () => PerfilAdmin()),
          GetPage(name: "/editAdmin", page: () => EditAdmin()),
          GetPage(name: "/mySheets", page: () => MySheets()),
          GetPage(name: "/perfilStudent", page: () => PerfilStudent()),
          GetPage(name: "/editStudent", page: () => EditStudent())
        ],
      ),
    ),
  );
}
