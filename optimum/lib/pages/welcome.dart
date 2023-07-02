import 'package:flutter/material.dart';


class Welcome extends StatefulWidget {

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welc.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome',
                     style: TextStyle(
                       fontSize: 45.0,
                       letterSpacing: 2.0,
                       color: Colors.black,
                       fontFamily: 'Oswald',
                    ),
                  ),
                SizedBox(height: 6.0),
                Text(
                 'La taille standard d''un logo d''application peut varier en fonction des besoins spécifiques de l''application',
                 style: TextStyle(
                   fontSize: 13.0,
                   letterSpacing: 2.0,
                   color: Colors.grey[500],
                   fontFamily: 'Poppins',
                 ),
               ),
                ],
              ),
            ),
            SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(120.0, 0, 0, 0),
              child: Container(
                width: 150.0,
                height: 50.0,
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
                  onPressed: (){
                    Navigator.pushNamed(context, '/start');
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Oswald',
                      fontSize: 20.0,
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

