import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/pages/verifyUser.dart';
import 'package:optimum/services/auth.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../shared/loading.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Drcreateaccount extends StatefulWidget {
  //final Function toggleView;
  //Drcreateaccount({required this.toggleView});

  @override
  State<Drcreateaccount> createState() => _DrcreateaccountState();
}

class _DrcreateaccountState extends State<Drcreateaccount> {
  final _formKey = GlobalKey<FormState>();

  String nom = '';
  String prenom = '';
  String email = '';
  String password = '';
  String confirmPasswd = '';
  String error = '';
  bool loading = false;

  String? validateName(String value) {
    String trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Veuillez entrer votre prénom.';
    }
    return null;
  }

  String? validateLastName(String value) {
    String trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Veuillez entrer votre nom.';
    }
    return null;
  }

  String? validateEmail(String value) {
    value = value.trim();
    if (value != null &&
        !RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
            .hasMatch(value)) {
      return 'Adresse e-mail invalide';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != password) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> createNewDocument(String email) async {
      final firestore = FirebaseFirestore.instance;

      // Reference to the Firestore collection where you want to add the document
      final collectionReference = firestore.collection('listMedecins');
      // Create a new document with an auto-generated ID and email attribute
      await collectionReference.add({
        'email': email,
      });
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'sign_dark'
        : 'sign';

    return loading
        ? Loading()
        : Scaffold(
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
                            screenHeight * 0.15,
                            screenWidth * 0.3,
                            0,
                          ),
                          child: Text(
                            'Create Account',
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
                                // TextFormField(
                                //   onChanged: (value) {
                                //     setState(() {
                                //       prenom = value;
                                //     });
                                //     prenom = prenom.trim();
                                //   },
                                //   validator: (value) {
                                //     return validateName(value!);
                                //   },
                                //   decoration: InputDecoration(
                                //     hintText: 'First Name',
                                //     hintStyle: TextStyle(
                                //       color: Color(0xFFD9D9D9),
                                //     ),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(height: screenHeight * 0.02),
                                // TextFormField(
                                //   onChanged: (value) {
                                //     setState(() {
                                //       nom = value;
                                //     });
                                //     nom = nom.trim();
                                //   },
                                //   validator: (value) {
                                //     return validateLastName(value!);
                                //   },
                                //   decoration: InputDecoration(
                                //     hintText: 'Last Name',
                                //     hintStyle: TextStyle(
                                //       color: Color(0xFFD9D9D9),
                                //     ),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(height: screenHeight * 0.02),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                    email = email.trim();
                                  },
                                  validator: (value) {
                                    return validateEmail(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email',
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
                                // TextFormField(
                                //   onChanged: (value) {
                                //     setState(() {
                                //       password = value;
                                //     });
                                //   },
                                //   validator: (value) {
                                //     return validatePassword(value!);
                                //   },
                                //   obscureText: true,
                                //   decoration: InputDecoration(
                                //     hintText: 'Password',
                                //     hintStyle: TextStyle(
                                //       color: Color(0xFFD9D9D9),
                                //     ),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(height: screenHeight * 0.02),
                                // TextFormField(
                                //   onChanged: (value) {
                                //     setState(() {
                                //       confirmPasswd = value;
                                //     });
                                //   },
                                //   validator: (value) {
                                //     return validateConfirmPassword(value!);
                                //   },
                                //   obscureText: true,
                                //   decoration: InputDecoration(
                                //     hintText: 'Confirm Password',
                                //     hintStyle: TextStyle(
                                //       color: Color(0xFFD9D9D9),
                                //     ),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(40.0),
                                //       borderSide: BorderSide(
                                //         color: Color(0xFFD9D9D9),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                      //la validation avant la requete

                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        await createNewDocument(email);
                                        setState(() {
                                          loading = false;
                                        });
                                        Navigator.pop(context);
                                        final snackBar = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'Doctor added!',
                                            message:
                                                'The doctor $email has been added succefuly',
                                            contentType: ContentType.success,
                                          ),
                                        );

                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(snackBar);
                                      }
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
                                Text(
                                  error,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.073),
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
