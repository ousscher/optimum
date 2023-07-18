import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:optimum/provider/theme_provider.dart';
import 'package:optimum/services/auth.dart';



void main()async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Lock to portrait orientation
  ]);
  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Light & Dark Theme';
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return MaterialApp(
        title: title,
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: Welcome(),
      );
    },
  );
  }


