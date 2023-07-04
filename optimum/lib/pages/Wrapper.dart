import 'package:firebase_auth/firebase_auth.dart';
import 'package:optimum/models/user.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/create_account_page.dart';
import 'package:optimum/pages/home.dart';
import 'package:optimum/pages/start.dart';
import 'package:optimum/services/auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  User? utilisateur = AuthService.getAuth().currentUser;

  Wrapper({super.key,});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  

  @override
  Widget build(BuildContext context) {
    return widget.utilisateur == null ? Start() : Home() ;
  }
}
