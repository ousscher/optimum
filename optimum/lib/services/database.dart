import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/clinic.dart';
import 'package:optimum/models/user.dart';

class DatabaseService {
  // collection reference
  static String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseService();
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  static final CollectionReference medsCollections =
      FirebaseFirestore.instance.collection('meds');
  static final CollectionReference clinicCollection =
      FirebaseFirestore.instance.collection('clinic');
  Future intialiseUserData(String name, String lastName, String email) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'lastname': lastName,
      'email': email,
    });
  }

  Future intialiseMedecinData(
      String uid, String name, String lastName, String email) async {
    return await medsCollections.doc(uid).set({
      'name': name,
      'lastname': lastName,
      'email': email,
      'uid': uid,
    });
  }

  // get nom d'utilisateur

  static Stream<List<Medecin>> get meds {
    return medsCollections
        .snapshots()
        .map((event) => medecinListFromSnapshot(event));
  }

  static Stream<List<UserOptimum>> get users {
    return usersCollection
        .snapshots()
        .map((event) => userListFromSnapshot(event));
  }

  //users list from a snapshot

  static Stream<List<Map<String, dynamic>?>> get appoinments {
    final medecinReference =
        FirebaseFirestore.instance.collection('meds').doc(uid);
    return medecinReference
        .collection('appointments')
        .snapshots()
        .map((event) => appoinmentListFromSnapshot(event));
  }

  static Stream<List<Map<String, dynamic>?>> get appoinmentsPatient {
    final userRefernce = FirebaseFirestore.instance
        .collection('users')
        .doc(uid);
    return userRefernce.collection('appointments')
        .snapshots()
        .map((event) => appoinmentListFromSnapshot(event));
  }
  //----------------------------------------------------

  static List<UserOptimum> userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data =
          doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      return UserOptimum(
        uid: uid,
        name: data?['name'] ?? '',
        lastName: data?['lastname'] ?? '',
        email: data?['email'] ?? '',
        urlPhoto: data?['urlPhoto'],
      );
    }).toList();
  }

  static List<Medecin> medecinListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data =
          doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      // Map<String, dynamic> calenderData = data?['calender'];
      // Calender calender = Calender();
      // Map<String, dynamic> daysList = data?['days'];
      // daysList.forEach((key, value) {
      //   String date = value['date'];
      //   print(date);
      // });
      return Medecin(
        uid: data?['uid'] ?? '',
        name: data?['name'] ?? '',
        lastName: data?['lastname'] ?? '',
        email: data?['email'] ?? '',
        urlPhoto: data?['profilePhotoURL'],
        professionalCreer: data?['professionalCarrer'],
        phone: data?['phone'],
        specialite: data?['specialite'],
        attendece:  data?['attendence'],
        // calender: data?['calender'] ?? Calender(),
        // calender: Calender(),
        // calender:
      );
    }).toList();
  }

  static List<Map<String, dynamic>?> appoinmentListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data =
          doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      return data;
    }).toList();
  }

  //appoinment card

//get user snapshot
  static Stream<Patient> get userData {
    return usersCollection.doc(uid).snapshots().map(userFromSnapshot);
  }

  static Stream<Medecin> get medData {
    return medsCollections.doc(uid).snapshots().map(medFromSnapshot);
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

  static Medecin medFromSnapshot(DocumentSnapshot snapshot) {
    // Stream<DocumentSnapshot> snapshot = usersCollection.doc(uid).snapshots();
    // Map<String, dynamic> data =
    //     (snapshot.data() as Map<dynamic, dynamic>)['calender'];
    // Set<Day> days = Set<Day>();

    // if (data.containsKey('days')) {
    //   List<dynamic> daysData = data['days'];
    //   for (var dayData in daysData) {
    //     String date = dayData['date'];

    //     Set<TimeSlot> timeSlots = Set<TimeSlot>();
    //     if (dayData.containsKey('timeSlots')) {
    //       List<dynamic> timeSlotsData = dayData['timeSlots'];
    //       for (var slotData in timeSlotsData) {
    //         String start = slotData['start'];
    //         String end = slotData['end'];
    //         bool available = slotData['available'];
    //         TimeSlot timeSlot = TimeSlot(
    //           start: start,
    //           end: end,
    //         );
    //         timeSlot.setAvailability(available);
    //         timeSlots.add(timeSlot);
    //       }
    //     }

    //     Day day = Day(date: date, timeSlots: timeSlots);
    //     days.add(day);
    //   }
    // }
    // Calender calender = Calender();
    // calender.setDays(days);

    return Medecin(
      uid: (snapshot.data() as Map<dynamic, dynamic>)['uid'],
      name: (snapshot.data() as Map<dynamic, dynamic>)['name'],
      lastName: (snapshot.data() as Map<dynamic, dynamic>)['lastname'],
      email: (snapshot.data() as Map<dynamic, dynamic>)['email'],
      urlPhoto: (snapshot.data() as Map<dynamic, dynamic>)['profilePhotoURL'],
      specialite: (snapshot.data() as Map<dynamic, dynamic>)['specialite'],
      professionalCreer:
          (snapshot.data() as Map<dynamic, dynamic>)['professionalCarrer'],
      phone: (snapshot.data() as Map<dynamic, dynamic>)['phone'],
      attendece: (snapshot.data() as Map<dynamic, dynamic>)['attendence'],
      // calender: calender,
      // calender: Calender(),
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

  static Future<void> updateDoctor(Medecin? medecin) async {
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
      // if (medecin.getCalender() != null) {
      //   dataToUpdate['calender'] = medecin.getCalender();
      // } else {
      //   dataToUpdate['calender'] = FieldValue.delete();
      // }

      await FirebaseFirestore.instance
          .collection('meds')
          .doc(medecin.getUid())
          .update(dataToUpdate);
      print('Mise à jour réussie');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }

  static Stream<Clinic> get clinicData {
    return clinicCollection
        .doc("4vWaNsKXtDBNEar4FvUZ")
        .snapshots()
        .map((event) {
      return Clinic(
          email: (event.data() as Map<dynamic, dynamic>)['email']??"",
          phone: (event.data() as Map<dynamic, dynamic>)['phone']??"",
          adress: (event.data() as Map<dynamic, dynamic>)['adress']??"",
          facebookAccount: (event.data() as Map<dynamic, dynamic>)['facebookAccount']??"",
          locationLink: (event.data() as Map<dynamic, dynamic>)['locationLink']??"",
          instaAccount: (event.data() as Map<dynamic, dynamic>)['instaAccount']??"");
    });
  }

    static Future<void> updateClinic(Clinic? clinic) async {
    try {
      // Créez un Map pour stocker les données à mettre à jour
      final Map<String, dynamic> dataToUpdate = {};
      dataToUpdate['adress'] = clinic!.getAdress();
      dataToUpdate['email'] = clinic.getEmail();
      dataToUpdate['facebookAccount'] = clinic.getFacebookAccount();
      dataToUpdate['instaAccount'] = clinic.getInstaAccount();
      dataToUpdate['locationLink'] = clinic.getLocationLink();
      dataToUpdate['phone'] = clinic.getPhone();

      

      await clinicCollection
          .doc("4vWaNsKXtDBNEar4FvUZ")
          .update(dataToUpdate);
      print('Mise à jour réussie');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }
}
