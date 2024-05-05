import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/clinic.dart';
import 'package:optimum/models/user.dart';

class DatabaseService {
  // collection reference
  String uid = FirebaseAuth.instance.currentUser!.uid;
  User? user = FirebaseAuth.instance.currentUser;
  DatabaseService();
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference _medsCollections = FirebaseFirestore.instance.collection('meds');
  final CollectionReference _clinicCollection = FirebaseFirestore.instance.collection('clinic');
  Future intialiseUserData(
      String name, String lastName, String email, String gender) async {
    return await _usersCollection.doc(uid).set(
        {'name': name, 'lastname': lastName, 'email': email, 'gender': gender});
  }

  Future intialiseMedecinData(String uid, String name, String lastName,
      String email, String gender) async {
    return await _medsCollections.doc(uid).set({
      'name': name,
      'lastname': lastName,
      'email': email,
      'uid': uid,
      'gender': gender
    });
  }

  // get nom d'utilisateur

  Stream<List<Medecin>> get meds {
    return _medsCollections
        .snapshots()
        .map((event) => medecinListFromSnapshot(event));
  }

  Stream<List<UserOptimum>> get users {
    return _usersCollection
        .snapshots()
        .map((event) => userListFromSnapshot(event));
  }

  //users list from a snapshot

  Stream<List<Map<String, dynamic>?>> get appoinments {
    final medecinReference =
        FirebaseFirestore.instance.collection('meds').doc(uid);
    return medecinReference
        .collection('appointments')
        .snapshots()
        .map((event) => appoinmentListFromSnapshot(event));
  }

  Stream<List<Map<String, dynamic>?>> get appoinmentsPatient {
    final userRefernce =
        FirebaseFirestore.instance.collection('users').doc(uid);
    return userRefernce
        .collection('appointments')
        .snapshots()
        .map((event) => appoinmentListFromSnapshot(event));
  }

  Future<void> updateStatus(
    String status,
    String idUser,
    String idDoctor,
    String? idAppoinmentUser,
    String idAppoinmentDoctor,
  ) async {
    final medecinRef =
        FirebaseFirestore.instance.collection('meds').doc(idDoctor);
    final appointmentCollection = medecinRef.collection('appointments');
    try {
      await appointmentCollection.doc(idAppoinmentDoctor).update({
        'status': status,
      });
    } catch (e) {
      print('Error updating document: $e');
    }
    if (idUser.isNotEmpty) {
      try {
        final patientRef =
            FirebaseFirestore.instance.collection('users').doc(idUser);
        final appointmentCollection2 = patientRef.collection('appointments');
        await appointmentCollection2.doc(idAppoinmentUser).update({
          'status': status,
        });
      } catch (e) {
        print('Erreur lors de la mise à jour : $e');
      }
    }
  }

  Stream<List<Map<String, dynamic>?>> get n {
    final medecinReference =
        FirebaseFirestore.instance.collection('meds').doc(uid);
    return medecinReference
        .collection('appointments')
        .snapshots()
        .map((event) => appoinmentListFromSnapshot(event));
  }

  Stream<List<Map<String, dynamic>?>> get a {
    final userRefernce =
        FirebaseFirestore.instance.collection('users').doc(uid);
    return userRefernce
        .collection('appointments')
        .snapshots()
        .map((event) => appoinmentListFromSnapshot(event));
  }
  //----------------------------------------------------

  List<UserOptimum> userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data =
          doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      return UserOptimum(
        uid: uid,
        name: data?['name'] ?? '',
        lastName: data?['lastname'] ?? '',
        email: data?['email'] ?? '',
        gender: data?["gender"] ?? '',
        urlPhoto: data?['urlPhoto'],
      );
    }).toList();
  }

  List<Medecin> medecinListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data =
          doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      return Medecin(
        uid: data?['uid'] ?? '',
        name: data?['name'] ?? '',
        lastName: data?['lastname'] ?? '',
        gender: data?['gender'] ?? "",
        email: data?['email'] ?? '',
        urlPhoto: data?['profilePhotoURL'],
        professionalCreer: data?['professionalCarrer'],
        phone: data?['phone'],
        specialite: data?['specialite'],
        attendece: data?['attendence'],
      );
    }).toList();
  }

  List<Map<String, dynamic>?> appoinmentListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      // Cast to Map<String, dynamic>
      data!['id'] = doc.id;
      return data;
    }).toList();
  }

  //appoinment card

//get user snapshot
  Stream<Patient> get userData {
    return _usersCollection.doc(uid).snapshots().map(userFromSnapshot);
  }

  Stream<Medecin> get medData {
    return _medsCollections.doc(uid).snapshots().map(medFromSnapshot);
  }

  Patient userFromSnapshot(DocumentSnapshot snapshot) {
    return Patient(
      uid: uid,
      patientName: (snapshot.data() as Map<dynamic, dynamic>)['name'],
      patientLastName: (snapshot.data() as Map<dynamic, dynamic>)['lastname'],
      patientEmail: (snapshot.data() as Map<dynamic, dynamic>)['email'],
      gender: (snapshot.data() as Map<dynamic, dynamic>)['gender'],
      phone: (snapshot.data() as Map<dynamic, dynamic>)['phone'],
      urlPhoto: (snapshot.data() as Map<dynamic, dynamic>)['profilePhotoURL'],
      weight: (snapshot.data() as Map<dynamic, dynamic>)['weight'],
      height: (snapshot.data() as Map<dynamic, dynamic>)['height'],
      adress: (snapshot.data() as Map<dynamic, dynamic>)['adress'],
      dateOfBirth: (snapshot.data() as Map<dynamic, dynamic>)['dateOfBirth'],
      bloodType: (snapshot.data() as Map<dynamic, dynamic>)['bloodType'],
      alergic: (snapshot.data() as Map<dynamic, dynamic>)['allergic'],
      surgery: List<String>.from(
          (snapshot.data() as Map<String, dynamic>)['surgery']
                  ?.cast<String>() ??
              []),
      cronicDesease: List<String>.from(
          (snapshot.data() as Map<String, dynamic>)['cronicDesease']
                  ?.cast<String>() ??
              []),
    );
  }

  Medecin medFromSnapshot(DocumentSnapshot snapshot) {
    return Medecin(
      uid: (snapshot.data() as Map<dynamic, dynamic>)['uid'],
      name: (snapshot.data() as Map<dynamic, dynamic>)['name'],
      lastName: (snapshot.data() as Map<dynamic, dynamic>)['lastname'],
      email: (snapshot.data() as Map<dynamic, dynamic>)['email'],
      gender: (snapshot.data() as Map<dynamic, dynamic>)['gender'],
      urlPhoto: (snapshot.data() as Map<dynamic, dynamic>)['profilePhotoURL'],
      specialite: (snapshot.data() as Map<dynamic, dynamic>)['specialite'],
      professionalCreer:
          (snapshot.data() as Map<dynamic, dynamic>)['professionalCarrer'],
      phone: (snapshot.data() as Map<dynamic, dynamic>)['phone'],
      attendece: (snapshot.data() as Map<dynamic, dynamic>)['attendence'],
    );
  }

  //updating user information
  Future<void> updateUser(Patient? patient) async {
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
      if (patient.getWeight() != "" && patient.getWeight() != null) {
        dataToUpdate['weight'] = patient.getWeight();
      } else {
        dataToUpdate['weight'] = FieldValue.delete();
      }
      if (patient.getHeight() != "" && patient.getHeight() != null) {
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
      if (patient.getSurgery()!.isNotEmpty && patient.getSurgery() != null) {
        dataToUpdate['surgery'] = patient.getSurgery()!.toSet().toList();
      } else {
        dataToUpdate['surgery'] = FieldValue.delete();
      }
      if (patient.getCronicDesease()!.isNotEmpty &&
          patient.getCronicDesease() != null) {
        dataToUpdate['cronicDesease'] =
            patient.getCronicDesease()!.toSet().toList();
      } else {
        dataToUpdate['cronicDesease'] = FieldValue.delete();
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

  Future<void> updateDoctor(Medecin? medecin) async {
    try {
      // Créez un Map pour stocker les données à mettre à jour
      final Map<String, dynamic> dataToUpdate = {};
      dataToUpdate['name'] = medecin!.getName();
      dataToUpdate['lastname'] = medecin.getLastName();
      dataToUpdate['email'] = medecin.getEmail();

      if (medecin.getPhone() != null) {
        dataToUpdate['phone'] = medecin.getPhone();
      } else {
        dataToUpdate['phone'] = FieldValue.delete();
      }
      if (medecin.getAttendence() != null) {
        dataToUpdate['attendence'] = medecin.getAttendence();
      } else {
        dataToUpdate['attendence'] = FieldValue.delete();
      }

      if (medecin.getProfessionalCarrer() != null ||
          medecin.getProfessionalCarrer() != "") {
        dataToUpdate['professionalCarrer'] = medecin.getProfessionalCarrer();
      } else {
        dataToUpdate['professionalCarrer'] = FieldValue.delete();
      }
      if (medecin.getSpecialite() != null || medecin.getSpecialite() != "") {
        dataToUpdate['specialite'] = medecin.getSpecialite();
      } else {
        dataToUpdate['specialite'] = FieldValue.delete();
      }
      if (medecin.getUrlPhoto() != null) {
        dataToUpdate['profilePhotoURL'] = medecin.getUrlPhoto();
      } else {
        dataToUpdate['profilePhotoURL'] = FieldValue.delete();
      }

      await FirebaseFirestore.instance
          .collection('meds')
          .doc(medecin.getUid())
          .update(dataToUpdate);
      print('Mise à jour réussie');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }

  Stream<Clinic> get clinicData {
    return _clinicCollection
        .doc("4vWaNsKXtDBNEar4FvUZ")
        .snapshots()
        .map((event) {
      return Clinic(
          email: (event.data() as Map<dynamic, dynamic>)['email'] ?? "",
          phone: (event.data() as Map<dynamic, dynamic>)['phone'] ?? "",
          adress: (event.data() as Map<dynamic, dynamic>)['adress'] ?? "",
          facebookAccount:
              (event.data() as Map<dynamic, dynamic>)['facebookAccount'] ?? "",
          locationLink:
              (event.data() as Map<dynamic, dynamic>)['locationLink'] ?? "",
          instaAccount:
              (event.data() as Map<dynamic, dynamic>)['instaAccount'] ?? "");
    });
  }

  Future<void> updateClinic(Clinic? clinic) async {
    try {
      // Créez un Map pour stocker les données à mettre à jour
      final Map<String, dynamic> dataToUpdate = {};
      dataToUpdate['adress'] = clinic!.getAdress();
      dataToUpdate['email'] = clinic.getEmail();
      dataToUpdate['facebookAccount'] = clinic.getFacebookAccount();
      dataToUpdate['instaAccount'] = clinic.getInstaAccount();
      dataToUpdate['locationLink'] = clinic.getLocationLink();
      dataToUpdate['phone'] = clinic.getPhone();

      await _clinicCollection.doc("4vWaNsKXtDBNEar4FvUZ").update(dataToUpdate);
      print('Mise à jour réussie');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }

  Future<void> deleteDocumentByFieldValue(String valueToDelete) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("listMedecins");

      QuerySnapshot querySnapshot =
          await collection.where("email", isEqualTo: valueToDelete).get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }
    } catch (e) {
      print('Erreur lors de la suppression : $e');
    }
  }
}
