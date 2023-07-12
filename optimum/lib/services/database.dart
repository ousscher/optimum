import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';

class DatabaseService {
  // collection reference
  final String uid;
  DatabaseService({required this.uid});
  static final CollectionReference usersCollection =FirebaseFirestore.instance.collection('users');
  Future intialiseUserData(String name, String lastName , String email) async {
    return await usersCollection.doc(uid).set({
      'name' : name,
      'lastname' : lastName,
      'email' : email,
    });
  }

  // get nom d'utilisateur


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