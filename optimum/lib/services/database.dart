import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // collection reference
  final String uid;
  DatabaseService({required this.uid});
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(String name, String lastName) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'lastname': lastName,
    });
  }

  // get  users streams

  static Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}
