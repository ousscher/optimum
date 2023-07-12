import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/services/database.dart';

class VerifyUser extends StatefulWidget {
  String name;
  String lastName;
  String email;
  VerifyUser({super.key, required this.name, required this.lastName , required this.email});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  late User user;
  late Timer timer;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      verifyUser(widget.name, widget.lastName , widget.email);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/start.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            screenHeight * 0.26,
            0,
            0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.3,
                  0,
                  screenWidth * 0.08,
                  0,
                ),
                child: Text(
                  ' Please Verify Your Email to proceed !',
                  style: TextStyle(
                    fontSize: screenWidth * 0.13,
                    letterSpacing: 3,
                    color: Colors.white,
                    fontFamily: 'Oswald',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future verifyUser(String name, String lastName , String email) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.reload();
      if (user.emailVerified) {
        timer.cancel();
        //create a new user on firestore database

        await DatabaseService(uid: user.uid)
            .intialiseUserData(name, lastName ,email ); //updating data of user
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Wrapper()),
          (Route<dynamic> route) =>
              false, // Supprime toutes les routes précédentes
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
