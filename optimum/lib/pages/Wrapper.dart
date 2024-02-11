import 'package:firebase_auth/firebase_auth.dart';
import 'package:optimum/models/user.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/create_account_page.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/start.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:provider/provider.dart';
import '../DrApp/Dr_home_page.dart';

class Wrapper extends StatefulWidget {
  List<String> doctorsList;
  Wrapper({super.key, required this.doctorsList});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  User? utilisateur = AuthService.getAuth().currentUser;

  @override
  Widget build(BuildContext context) {
    if (utilisateur == null) {
      return Start();
    } else {
      if (utilisateur!.emailVerified) {
        //Creer l'instance de l'utilisateur avant de passer par le homeScreen
        // verifier si c'est un medecin
        if (widget.doctorsList.contains(utilisateur!.email)) {
          // if (utilisateur!.email == "lo_cherguelaine@esi.dz") {
          print("we are DRhome");
          utilisateur!.delete();
          return DrHome();
        } else {
          // utilisateur!.delete();
          print("we are home");
          return Home();
        }
      } else {
        // utilisateur!.delete();
        return Start();
      }
    }
  }
}
