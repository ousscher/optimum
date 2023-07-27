import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';

class DatabaseService {
  // collection reference
  static String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseService();
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future intialiseUserData(String name, String lastName, String email) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'lastname': lastName,
      'email': email,
    });
  }

  // get nom d'utilisateur

  static Stream<List<UserOptimum>> get users {
    return usersCollection
        .snapshots()
        .map((event) => userListFromSnapshot(event));
  }
  //users list from a snapshot

  static List<UserOptimum> userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data =
          doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      return UserOptimum(
        uid: uid,
        name: data?['name'] ?? '',
        lastName: data?['lastname'] ?? '',
        email: data?['email'] ?? '',
        urlPhoto: data?['profilePhotoUrl'],
      );
    }).toList();
  }

//get user snapshot
  static Stream<Patient> get userData {
    return usersCollection.doc(uid).snapshots().map(userFromSnapshot);
  }

  static Patient userFromSnapshot(DocumentSnapshot snapshot) {
    // Stream<DocumentSnapshot> snapshot = usersCollection.doc(uid).snapshots();
    return Patient(
      uid: uid,
      patientName: (snapshot.data() as Map<dynamic, dynamic>)['name'],
      patientLastName: (snapshot.data() as Map<dynamic, dynamic>)['lastname'],
      patientEmail: (snapshot.data() as Map<dynamic, dynamic>)['email'],
      phone: (snapshot.data() as Map<dynamic, dynamic>)['phone'],
      urlPhoto: (snapshot.data() as Map<dynamic, dynamic>)['profilePhotoURL'],
      weight: (snapshot.data() as Map<dynamic, dynamic>)['weight'],
      height: (snapshot.data() as Map<dynamic, dynamic>)['height'],
      adress: (snapshot.data() as Map<dynamic, dynamic>)['adress'],
      dateOfBirth: (snapshot.data() as Map<dynamic, dynamic>)['dateOfBirth'],
      bloodType: (snapshot.data() as Map<dynamic, dynamic>)['bloodType'],
      alergic: (snapshot.data() as Map<dynamic, dynamic>)['allergic'],

    );
  }

  //updating user information
  static Future<void> updateUser(Patient? patient) async {
    try {
      // Créez un Map pour stocker les données à mettre à jour
      final Map<String, dynamic> dataToUpdate = {};
      dataToUpdate['name'] = patient!.getName();
      dataToUpdate['lastname'] = patient.getLastName();
      dataToUpdate['email'] = patient.getEmail();

      if (patient.getAdress() != null) {
        dataToUpdate['adress'] = patient.getAdress();
      } else {
        dataToUpdate['adress'] = FieldValue.delete();
      }
      if (patient.getWeight() != null) {
        dataToUpdate['weight'] = patient.getWeight();
      } else {
        dataToUpdate['weight'] = FieldValue.delete();
      }
      if (patient.getHeight() != null) {
        dataToUpdate['height'] = patient.getHeight();
      } else {
        dataToUpdate['height'] = FieldValue.delete();
      }
      if (patient.getPhone() != null) {
        dataToUpdate['phone'] = patient.getPhone();
      } else {
        dataToUpdate['phone'] = FieldValue.delete();
      }
      if (patient.getDateBirth() != null) {
        dataToUpdate['dateOfBirth'] = patient.getDateBirth();
      } else {
        dataToUpdate['dateOfBirth'] = FieldValue.delete();
      }
      if (patient.getBloodType() != null) {
        dataToUpdate['bloodType'] = patient.getBloodType();
      } else {
        dataToUpdate['bloodType'] = FieldValue.delete();
      }
      if (patient.getAlergic() != null) {
        dataToUpdate['allergic'] = patient.getAlergic();
      } else {
        dataToUpdate['allergic'] = FieldValue.delete();
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(patient.getUid())
          .update(dataToUpdate);
      print('Mise à jour réussie');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }
}
