import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/pages/changedPassword.dart';
import 'package:optimum/pages/sign_page.dart';
import 'package:optimum/shared/loading.dart';
import 'package:optimum/services/auth.dart';

import 'authenticate.dart';

class ResetEmailPage extends StatefulWidget {
  const ResetEmailPage({super.key});

  @override
  State<ResetEmailPage> createState() => _ResetEmailPageState();
}

class _ResetEmailPageState extends State<ResetEmailPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String error = '';
  bool loading = false;

  String? validateEmail(String value) {
    value = value.trim();
    if (value != null &&
        !RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
            .hasMatch(value)) {
      return 'Adresse e-mail invalide';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/reset_password.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    screenHeight * 0.575,
                    0,
                    0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Reset Your Password',
                            style: TextStyle(
                              color: Color(0xFF66B3FF),
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontFamily: 'Oswald',
                            ),
                          ),

                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          'Please enter your email',
                          style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontSize: screenWidth * 0.04,
                            letterSpacing: 1.0,
                            fontFamily: 'Poppins',
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
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.1),
                                    borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.1),
                                    borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.1),
                                    borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                  email = email.trim();
                                },
                                validator: (value) {
                                  return validateEmail(value!);
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.07,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Color(0xFFD37777);
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.05),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              //la validation de la requete
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                loading = true;
                                });
                                AuthService.getAuth()
                                    .sendPasswordResetEmail(email: email)
                                    .then((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Authenticate(showSignIn: true)),
                                  );
                                }).catchError((e) {
                                  setState(() {
                                    error =
                                        'Could not find those credentials';
                                    loading = false;
                                  });
                                });
                                final snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Let\'s go to mail!',
                                    message:
                                    'We gave you a chance to change your password. Please check your inbox and set a new password inorder to Sign in!',
                                    contentType: ContentType.warning,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Oswald',
                                fontSize: screenWidth * 0.065,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.04,
                            0,
                            0,
                            screenWidth * 0.1,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

