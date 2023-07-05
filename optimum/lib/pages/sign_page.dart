import 'package:flutter/material.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/shared/loading.dart';

class Sign extends StatefulWidget {
  Function toggleView;
  Sign({required this.toggleView});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String passwd = '';
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

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    // Autres conditions de validation si nécessaire
    return null; // Retourne null si la validation réussit
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
                    image: AssetImage('assets/images/sign.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.06,
                    screenHeight * 0.36,
                    screenWidth * 0.06,
                    0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            0,
                            screenWidth * 0.5,
                            0,
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xFF66B3FF),
                              fontSize: screenWidth * 0.1,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              fontFamily: 'Oswald',
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xFFD9D9D9),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
                              borderSide: BorderSide(
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
                              borderSide: BorderSide(
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
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
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Color(0xFFD9D9D9),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
                              borderSide: BorderSide(
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
                              borderSide: BorderSide(
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
                              borderSide: BorderSide(
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              passwd = value;
                            });
                          },
                          validator: (value) {
                            return validatePassword(value!);
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.4,
                            0,
                            0,
                            0,
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: screenWidth * 0.043,
                                fontFamily: 'Poppins',
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Container(
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.04),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              //la validation de la requete
                              setState(() {
                                loading = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                dynamic result =
                                    await AuthService.signInWithEmailAndPasswd(
                                        email, passwd);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Could not sign in with those credentials';
                                    loading = false;
                                  });
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Wrapper()),
                                    (Route<dynamic> route) =>
                                        false, // Supprime toutes les routes précédentes
                                  );
                                }
                              }
                            },
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Oswald',
                                fontSize: screenWidth * 0.075,
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
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Dont have Account?',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.043,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 1,
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: Color(0xFF66B3FF),
                                    fontSize: screenWidth * 0.043,
                                    fontFamily: 'Poppins',
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
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
