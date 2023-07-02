
import 'package:flutter/material.dart';
import 'package:optimum/pages/welcome.dart';
import 'package:optimum/pages/create_account_page.dart';
import 'package:optimum/pages/sign_page.dart';
import 'package:optimum/pages/start.dart';



void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => Welcome(),
      '/start': (context) => Start(),
      '/sign': (context) => Sign(),
      '/createaccount': (context) => Createaccount(),
    },
  ));
}


