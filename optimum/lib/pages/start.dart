import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/authenticate.dart';
import 'package:optimum/services/auth.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(110.0, 0, 40.0, 0),
                  child: Text(
                    ' Find a Medical Service',
                    style: TextStyle(
                      fontSize: 50.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontFamily: 'Oswald',
                    ),
                  ),
                ),
                SizedBox(height: 120.0),
                Container(
                  width: 165.0,
                  height: 40.0,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color(0xFFD37777);
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Authenticate(showSignIn:true),),);
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Oswald',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 165.0,
                  height: 40.0,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color(0xFF00437A);
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(
                            color: Color(0xFFD37777),
                            //style: BorderStyle.solid,
                          ), // Add the desired border color
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Authenticate(showSignIn:false),),);
                    },
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: Color(0xFFD37777),
                        fontFamily: 'Oswald',
                        fontSize: 15.0,
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
