import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyUser extends StatefulWidget {
  String name;
  String lastName;
  String email;
  VerifyUser(
      {super.key,
      required this.name,
      required this.lastName,
      required this.email, 
      });

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
      verifyUser( widget.name, widget.lastName, widget.email);
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
            image: AssetImage('assets/images/verify_email.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, screenHeight * 0.48, 0, 0),
          child: Container(
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.07, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' Verify Your Email Address',
                    style: TextStyle(
                      color: Color(0xFF66B3FF),
                      fontSize: screenWidth * 0.08,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald',
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    'Please confirm that you want to use this as your Optimum account email address. Once it\'s done you will be able to start booking appointments!',
                    style: TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Oswald',
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Let\'s go to mail!',
                          message:
                              'Your confirmation is very important to create your account!',
                          contentType: ContentType.help,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                    child: Text(
                      'What to do?',
                      style: TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.underline,
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.025, 0, 0, 0),
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.08,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Color(0xFFD37777);
                            },
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.04),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final Uri emailUri = Uri(
                            scheme: 'https',
                            host: 'mail.google.com',
                          );
                          try {
                            await launchUrl(emailUri);
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        child: Text(
                          'Verify my email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.06,
                            letterSpacing: 1.0,
                            fontFamily: 'Oswald',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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

  Future verifyUser(String name, String lastName, String email) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.reload();
      if (user.emailVerified) {
        timer.cancel();
        //create a new user on firestore database
        print(user.email);
        if (user.email == "lo_cherguelaine@esi.dz")
          await DatabaseService()
              .intialiseMedecinData(user.uid, name, lastName, email);
        else
          await DatabaseService().intialiseUserData(
              name, lastName, email); //initialise data of user
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
