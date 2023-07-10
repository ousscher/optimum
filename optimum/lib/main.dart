import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:optimum/services/auth.dart';
import 'package:provider/provider.dart';



void main()async {
  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Utilisateur?>.value(
      initialData: null,
      value: AuthService.user,
      child: MaterialApp(
        home:Welcome(),
      ),
    );
  }
}

