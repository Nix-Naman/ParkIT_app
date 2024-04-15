import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ParkModel extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<dynamic> parking_data = [];
  int? index;
  bool isSelected = false;
  Future<bool> login({required String email, required String pass}) async {
    try {
      var res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      return true;
    }on FirebaseAuthException catch (e) {
      if (e.code=='invalid-credential') {
        Fluttertoast.showToast(msg: "Invalid credential or user not registered.");
      }
      throw Exception(e);
    }
  }

  Future<void> signUp({required String email, required String pass}) async {
    try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      ).then((value) => Fluttertoast.showToast(msg: "Registeration Successful"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e, st) {
      print(st);
      throw Exception(e);
    }
  }

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
