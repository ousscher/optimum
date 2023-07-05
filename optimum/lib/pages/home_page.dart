import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        String name = snapshot.get('name');
        setState(() {
          userName = name;
        });
      } else {
        print('L\'utilisateur n\'existe pas dans Firestore');
      }
    } else {
      print('Aucun utilisateur connecté');
    }
  }
  @override
  Widget build(BuildContext context) {
    User? utilisateur = AuthService.getAuth().currentUser;
    final Size screenSize = MediaQuery.of(context).size;
    final nom =  DatabaseService(uid: utilisateur!.uid).getUserName();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, screenSize.height * 0.05, screenSize.width * 0.7, 0),
              child: FloatingActionButton(
                onPressed: () async {
                  await AuthService.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Wrapper()),
                    (Route<dynamic> route) =>
                        false, // Supprime toutes les routes précédentes
                  );
                }, // Menu button
                child: Icon(
                  Icons.menu,
                  color: Color(0xFFD37777),
                ),
                backgroundColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: screenSize.height * 0.3),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, screenSize.height * 0.06, screenSize.width * 0.2, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hi, ${this.userName}!',
                    style: TextStyle(
                      color: Color(0xFF66B3FF),
                      fontSize: screenSize.width * 0.11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontFamily: 'Oswald',
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.009),
                  Text(
                    'We hope that you are well!',
                    style: TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: screenSize.width * 0.045,
                      letterSpacing: 1.0,
                      fontFamily: 'poppins',
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.0045),
                  Text(
                    'So, how can we help you?',
                    style: TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: screenSize.width * 0.04,
                      letterSpacing: 1.0,
                      fontFamily: 'poppins',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.03),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  screenSize.width * 0.07, 0, screenSize.width * 0.12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.22,
                        height: screenSize.width * 0.22,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    screenSize.width * 0.15),
                                side: BorderSide(
                                  color: Color(0xFFD37777),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/schedule_icon.png',
                            width: screenSize.width * 0.15,
                            height: screenSize.height * 0.15,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      Text(
                        'Book appointment',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: screenSize.width * 0.04,
                          letterSpacing: 1.0,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.22,
                        height: screenSize.width * 0.22,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    screenSize.width * 0.15),
                                side: BorderSide(
                                  color: Color(0xFFD37777),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/phone_icon.png',
                            width: screenSize.width * 0.07,
                            height: screenSize.height * 0.07,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: screenSize.width * 0.04,
                          letterSpacing: 1.0,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.19, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.22,
                        height: screenSize.width * 0.22,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    screenSize.width * 0.15),
                                side: BorderSide(
                                  color: Color(0xFFD37777),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/location_icon.png',
                            width: screenSize.width * 0.07,
                            height: screenSize.height * 0.07,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: screenSize.width * 0.04,
                          letterSpacing: 1.0,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenSize.width * 0.19),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.22,
                        height: screenSize.width * 0.22,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    screenSize.width * 0.15),
                                side: BorderSide(
                                  color: Color(0xFFD37777),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/dr_icon.png',
                            width: screenSize.width * 0.11,
                            height: screenSize.height * 0.11,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      Text(
                        'About Dr',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: screenSize.width * 0.04,
                          letterSpacing: 1.0,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
