import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/DrApp/Dr_contact_page.dart';
import 'package:optimum/DrApp/Dr_profile.dart';
import 'package:optimum/DrApp/bookings.dart';
import 'package:optimum/DrApp/bookingsList.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/pages/contact.dart';
import 'package:optimum/pages/schedule.dart';
import 'package:optimum/pages/users.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:optimum/shared/loading.dart';
import '../services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optimum/models/profil.dart';
import '../provider/theme_provider.dart';
import 'Dr_menu.dart';

class DrHome extends StatefulWidget {
  DrHome({
    super.key,
  });
  @override
  State<DrHome> createState() => _DrHomeState();
}

class _DrHomeState extends State<DrHome> {
  Future<String>? userNameFuture;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'home_page_dark'
        : 'home_page';
    return Scaffold(
        body: StreamBuilder<Medecin>(
      stream: DatabaseService.medData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Medecin? medecin = snapshot.data;
          
          return StreamProvider<List<UserOptimum>?>.value(
            initialData: null,
            value: DatabaseService.users,
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/' + '$img' + '.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, screenSize.height * 0.06,
                          screenSize.width * 0.7, 0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DrMenu(
                                      malade: null,
                                    )),
                          );
                        }, // Menu button
                        child: Icon(
                          Icons.menu,
                          color: Color(0xFFD37777),
                        ),
                        backgroundColor: Theme.of(context).shadowColor,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.27),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, screenSize.height * 0.07, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // UsersList(), get the users data (all users using this widget + the database model )
                          Text(
                            'Hi, Dr.${medecin!.getName()}!',
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
                            'New day, new patient, new good deed',
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
                      padding: EdgeInsets.fromLTRB(screenSize.width * 0.04, 0,
                          screenSize.width * 0.12, 0),
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
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).shadowColor;
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
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => Schedule()),
                                    // );
                                  },
                                  child: Image.asset(
                                    'assets/images/schedule_ico.png',
                                    width: screenSize.width * 0.12,
                                    height: screenSize.height * 0.12,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.01),
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
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).shadowColor;
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookingsList()),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/schedule_icon.png',
                                    width: screenSize.width * 0.11,
                                    height: screenSize.height * 0.11,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.01),
                              Text(
                                'Bookings',
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
                      padding:
                          EdgeInsets.fromLTRB(screenSize.width * 0.13, 0, 0, 0),
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
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).shadowColor;
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DrContact()),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/phone_icon.png',
                                    width: screenSize.width * 0.07,
                                    height: screenSize.height * 0.07,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.01),
                              Text(
                                'Clinic Contact',
                                style: TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontSize: screenSize.width * 0.04,
                                  letterSpacing: 1.0,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: screenSize.width * 0.15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: screenSize.width * 0.22,
                                height: screenSize.width * 0.22,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).shadowColor;
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
                                  onPressed: () async {
                                    Medecin? m = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DrProfile(
                                                medecin: medecin,
                                              )),
                                    );
                                    if (m != null) {
                                      setState(() {
                                        medecin = m;
                                      });
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/dr_icon.png',
                                    width: screenSize.width * 0.11,
                                    height: screenSize.height * 0.11,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.01),
                              Text(
                                'Profile',
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
        } else {
          return Loading();
        }
      },
    ));
  }
}
