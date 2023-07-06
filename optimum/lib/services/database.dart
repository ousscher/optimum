import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

      if (snapshot.exists) {
        String name = snapshot.get('name');
        return name;
      } else {
        print('L\'utilisateur n\'existe pas dans Firestore');
        return '';
      }
    } else {
      print('Aucun utilisateur connecté');
      return '';
    }
  }
}