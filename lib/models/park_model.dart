import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParkModel extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<dynamic> parking_data = [];
  int? index;
  bool isSelected = false;
  Future<void> getData() async {
    await firestore
        .collection("Parking_Data")
        .doc("Indore")
        .get()
        .then((value) {
      // print(value.data()!['parking1']);
      parking_data = value.data()!['parking1'];
    });
    notifyListeners();
  }

  void bookPark(int indx) {
    index = indx;
    isSelected = true;
    notifyListeners();
  }
}
