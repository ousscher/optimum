import 'package:flutter/material.dart';

import 'package:optimum/pages/Safety.dart';
import 'package:optimum/pages/start.dart';
import 'package:optimum/pages/wrapper.dart';

class Welcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/welc.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.1,
                  screenHeight * 0.16,
                  screenWidth * 0.08,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: screenWidth * 0.12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontFamily: 'Oswald',
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'La taille standard d\'un logo d\'application peut varier en fonction des besoins spécifiques de l\'application',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        letterSpacing: 2.0,
                        color: Colors.grey[500],
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.42,
                  0,
                  screenWidth * 0.08,
                  0,
                ),
                child: Container(
                  width: screenWidth * 0.38,
                  height: screenHeight * 0.06,
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
                        MaterialPageRoute(builder: (context) => Safety()),
                      );
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Oswald',
                        fontSize: screenWidth * 0.047,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

