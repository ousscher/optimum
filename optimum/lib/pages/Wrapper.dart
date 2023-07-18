import 'package:firebase_auth/firebase_auth.dart';
import 'package:optimum/models/user.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/create_account_page.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/start.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  Patient? patient;
  Wrapper({
    super.key,
    this.patient
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = true;
  User? utilisateur = AuthService.getAuth().currentUser;
  @override
  Widget build(BuildContext context) {
    if (utilisateur == null) {
      return Start();
    } else {
      if (utilisateur!.emailVerified) {
        //Creer l'instance de l'utilisateur avant de passer par le homeScreen
        return Home();
      } else {
        utilisateur!.delete();
        return Start();
      }
    }
  }
}
