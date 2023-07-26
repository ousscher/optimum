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
      phone: (snapshot.data() as Map<dynamic, dynamic>)['phone'] ,
      urlPhoto: (snapshot.data() as Map<dynamic, dynamic>)['profilePhotoURL'],
      weight: (snapshot.data() as Map<dynamic, dynamic>)['weight'],
      height: (snapshot.data() as Map<dynamic, dynamic>)['height'],
    );
  }

  //updating user information
  static Future<void> updateUser(Patient? patient)async{
    try {
      // Créez un Map pour stocker les données à mettre à jour
      final Map<String, dynamic> dataToUpdate = {};
      dataToUpdate['name'] = patient!.getName();
      dataToUpdate['lastname'] = patient.getName();
      dataToUpdate['email'] = patient.getEmail();

      if (patient.getAdress() != null) {
        dataToUpdate['adress'] = patient.getAdress();
      } else {
        dataToUpdate['adress'] = FieldValue.delete();
      }
      if (patient.getWeight() != null) {
        dataToUpdate['weight'] = patient.getWeight().toString();
      } else {
        dataToUpdate['weight'] = FieldValue.delete();
      }
      if (patient.getHeight() != null) {
        dataToUpdate['height'] = patient.getHeight().toString();
      } else {
        dataToUpdate['height'] = FieldValue.delete();
      }
      if (patient.getPhone() != null) {
        dataToUpdate['phone'] = patient.getPhone();
      } else {
        dataToUpdate['phone'] = FieldValue.delete();
      }
      await FirebaseFirestore.instance.collection('users').doc(patient.getUid()).update(dataToUpdate);
      print('Mise à jour réussie');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
    if (patient.getWeight() != null) {
      dataToUpdate['weight'] = patient.getWeight().toString();
    } else {
      dataToUpdate['weight'] = FieldValue.delete();
    }
    if (patient.getHeight() != null) {
      dataToUpdate['height'] = patient.getHeight().toString();
    } else {
      dataToUpdate['height'] = FieldValue.delete();
    }
    if (patient.getPhone() != null) {
      dataToUpdate['phone'] = patient.getPhone();
    } else {
      dataToUpdate['phone'] = FieldValue.delete();
    }
    

  await FirebaseFirestore.instance.collection('users').doc(patient.getUid()).update(dataToUpdate);
    print('Mise à jour réussie');
  } catch (e) {
    print('Erreur lors de la mise à jour : $e');
  }
  }
}