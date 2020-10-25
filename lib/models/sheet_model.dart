import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SheetModel extends ChangeNotifier {

  CollectionReference getConnection() {
    return FirebaseFirestore.instance.collection("sheet");
  }
}