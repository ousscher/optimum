import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:optimum/pages/start.dart';
import 'package:optimum/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/auth.dart';


class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  final _formKey = GlobalKey<FormState>();
  String? email = FirebaseAuth.instance.currentUser?.email;
  String feedback = '';
  @override
  Widget build(BuildContext context) {

    Future<void> addFeedback(String email, String feedbackValue) async {
      try {
        await FirebaseFirestore.instance.collection('Feedback').add({
          'email': email,
          'feedback': feedbackValue,
        });
        print('Feedback added successfully for email $email');
      } catch (error) {
        print('Error adding feedback: $error');
      }
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'sign_dark'
        : 'sign';

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/' + '$img' + '.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.04,
              screenHeight * 0.06,
              screenWidth * 0.04,
              0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.fromLTRB(0, 0, screenWidth * 0.7, 0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Color(0xFFD37777),
                      ),
                      backgroundColor: Theme.of(context).shadowColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      screenHeight * 0.246,
                      screenWidth * 0.3,
                      0,
                    ),
                    child: Text(
                      'Your Feedback',
                      style: TextStyle(
                        color: Color(0xFF66B3FF),
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontFamily: 'Oswald',
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.05,
                      0,
                      screenWidth * 0.05,
                      0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[

                          SizedBox(height: screenHeight * 0.02),

                          SizedBox(height: screenHeight * 0.02),
                          TextFormField(
                            onChanged: (value) {
                                setState(() {
                                feedback = value;
                                });
                                feedback = feedback.trim();
                            },
                            decoration: InputDecoration(
                              hintText: 'Feedback',
                              hintStyle: TextStyle(
                                color: Color(0xFFD9D9D9),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          SizedBox(height: screenHeight * 0.02),
                          Container(
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.065,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty
                                    .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    return Color(0xFFD37777);
                                  },
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                  addFeedback(email!, feedback);
                                  Navigator.pop(context);
                                  final snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Feedback registred!',
                                      message:
                                      'Feedback recorded. Thank you for helping us improve your experience',
                                      contentType: ContentType.success,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);

                              },
                              child: Text(
                                'Create',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Oswald',
                                  fontSize: screenHeight * 0.03,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          //Text(
                          //  error,
                          //  style: const TextStyle(
                          //    color: Colors.red,
                          //    fontSize: 14.0,
                          //  ),
                          //),
                          SizedBox(height: screenHeight * 0.3),
                        ],
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
}
