import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/Doctors.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/pages/contact.dart';
import 'package:optimum/pages/users.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:optimum/shared/loading.dart';
import '../services/auth.dart';
import 'menu.dart';
import 'package:optimum/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optimum/models/profil.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<String>? userNameFuture;

  @override
  void initState() {
    super.initState();
    userNameFuture = fetchUserName();
  }

  Future<String> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        String name = snapshot.get('name');
        return name;
      } else {
        print('L\'utilisateur n\'existe pas dans Firestore');
      }
    } else {
      print('Aucun utilisateur connecté');
    }

    return ''; // Retourner une valeur par défaut
  }

  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            // Votre code ici
            child: FutureBuilder<String>(
                future: userNameFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Afficher un indicateur de chargement
                    return Loading();
                  }
                  if (snapshot.hasData) {
                    // Récupérer le nom de l'utilisateur depuis le snapshot
                    String userName = snapshot.data!;
                    return StreamProvider<List<UserOptimum>?>.value(
                      initialData: null,
                      value: DatabaseService.users,
                      child: Scaffold(
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
                                    0,
                                    screenSize.height * 0.06,
                                    screenSize.width * 0.7,
                                    0),
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Menu()),
                                    );
                                  }, // Menu button
                                  child: Icon(
                                    Icons.menu,
                                    color: Color(0xFFD37777),
                                  ),
                                  backgroundColor: Colors.grey[100],
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.27),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    screenSize.height * 0.07,
                                    screenSize.width * 0.15,
                                    0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // UsersList(), get the users data (all users using this widget + the database model )
                                    Text(
                                      'Hi, $userName!',
                                      style: TextStyle(
                                        color: Color(0xFF66B3FF),
                                        fontSize: screenSize.width * 0.11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0,
                                        fontFamily: 'Oswald',
                                      ),
                                    ),
                                    SizedBox(height: screenSize.height * 0.005),
                                    Text(
                                      'We hope that you are well!',
                                      style: TextStyle(
                                        color: Color(0xFFD9D9D9),
                                        fontSize: screenSize.width * 0.04,
                                        letterSpacing: 1.0,
                                        fontFamily: 'poppins',
                                      ),
                                    ),
                                    SizedBox(height: screenSize.height * 0.002),
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
                                    screenSize.width * 0.07,
                                    0,
                                    screenSize.width * 0.12,
                                    0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: screenSize.width * 0.22,
                                          height: screenSize.width * 0.22,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  return Colors.white;
                                                },
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenSize.width *
                                                              0.15),
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
                                        SizedBox(
                                            height: screenSize.height * 0.01),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: screenSize.width * 0.22,
                                          height: screenSize.width * 0.22,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  return Colors.white;
                                                },
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenSize.width *
                                                              0.15),
                                                  side: BorderSide(
                                                    color: Color(0xFFD37777),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Contact()),
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/images/phone_icon.png',
                                              width: screenSize.width * 0.07,
                                              height: screenSize.height * 0.07,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: screenSize.height * 0.01),
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
                                padding: EdgeInsets.fromLTRB(
                                    screenSize.width * 0.19, 0, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: screenSize.width * 0.22,
                                          height: screenSize.width * 0.22,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  return Colors.white;
                                                },
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenSize.width *
                                                              0.15),
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
                                        SizedBox(
                                            height: screenSize.height * 0.01),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: screenSize.width * 0.22,
                                          height: screenSize.width * 0.22,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  return Colors.white;
                                                },
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenSize.width *
                                                              0.15),
                                                  side: BorderSide(
                                                    color: Color(0xFFD37777),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => Doctors()),
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/images/dr_icon.png',
                                              width: screenSize.width * 0.11,
                                              height: screenSize.height * 0.11,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: screenSize.height * 0.01),
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
                      ),
                    );
                  }
                  return Text(
                    'Unable to fetch user data',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: screenSize.width * 0.04,
                      fontFamily: 'poppins',
                    ),
                  );
                })));
  }
}
