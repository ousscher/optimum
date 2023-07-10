import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';

class DatabaseService {
  // collection reference
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference optimumCollection =FirebaseFirestore.instance.collection('users');
  Future updateUserData(String name, String lastName) async {
    return await optimumCollection.doc(uid).set({
      'name' : name,
      'lastname' : lastName,

    });
  }

  // get nom d'utilisateur

  Future<String> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

  static Stream<List<UserOptimum>> get users {
    return usersCollection.snapshots().map((event) => userListFromSnapshot(event));
  }
  //users list from a snapshot

  static List<UserOptimum> userListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
    return UserOptimum(
      name: data?['name'] ?? '',
      lastName: data?['lastname'] ?? '',
    );
  }).toList();
}


}

