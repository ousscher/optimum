import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/authenticate.dart';
import 'package:optimum/services/auth.dart';
import 'package:provider/provider.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return StreamProvider<Utilisateur?>.value(
      initialData: null,
      value: AuthService.user,
      child: Scaffold(
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
                      ' Find a Medical Service',
                      style: TextStyle(
                        fontSize: screenWidth * 0.13,
                        letterSpacing: 3,
                        color: Colors.white,
                        fontFamily: 'Oswald',
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.18),
                  Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.055,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            return Color(0xFFD37777);
                          },
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.1),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Authenticate(showSignIn: true)),
                        );
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Oswald',
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.055,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            return Color(0xFF00437A);
                          },
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.1),
                            side: BorderSide(
                              color: Color(0xFFD37777),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Authenticate(showSignIn: false)),
                        );
                      },
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          color: Color(0xFFD37777),
                          fontFamily: 'Oswald',
                          fontSize: screenWidth * 0.042,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
