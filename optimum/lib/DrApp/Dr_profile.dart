import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/DrApp/Dr_edit_profile.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/edit_pesonal_profile_page.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/menu.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:optimum/shared/loading.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class DrProfile extends StatefulWidget {
  //Patient? patient;
  Medecin? medecin;
  DrProfile({super.key, required this.medecin});

  @override
  State<DrProfile> createState() => _DrProfileState();
}

class _DrProfileState extends State<DrProfile> {
  final user = AuthService.getAuth().currentUser;

  @override
  Widget build(BuildContext context) {
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'menu_dark'
        : 'menu';
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/' + '$img' + '.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenSize.width * 0.06,
                          screenSize.height * 0.06, 0, 0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, // Menu button
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFFD37777),
                        ),
                        backgroundColor: Theme.of(context).shadowColor,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.06,
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(screenSize.width * 0.136, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height * 0.06,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: screenSize.height * 0.06,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
                Container(
                  width: screenSize.width * 0.26,
                  height: screenSize.width * 0.26,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                    border: Border.all(
                      width: 2.0,
                      color: Color(0xFFD37777),
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: widget.medecin!.getUrlPhoto() == null
                            ? AssetImage('assets/images/profil_pic.png')
                            : Image.network(widget.medecin!.getUrlPhoto()!)
                                .image,
                        fit: BoxFit.cover),
                  ),
                ),
            SizedBox(
              height: screenSize.height * 0.015,
            ),
            Text(
              '${widget.medecin!.getLastName()} ${widget.medecin!.getName()}',
              /*${widget.patient!.getName()} ${widget.patient!.getLastName()}*/
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: screenSize.height * 0.04,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  screenSize.height * 0.01, 0, screenSize.height * 0.01, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/phone_icon.png',
                              width: screenSize.width * 0.08,
                              height: screenSize.width * 0.08,
                            ),
                            SizedBox(
                              width: screenSize.width * 0.04,
                            ),
                            Text(
                              widget.medecin!.getPhone() ?? "Not mentioned",
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: screenSize.height * 0.02,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenSize.width * 0.15,
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/email_icon.png',
                              width: screenSize.width * 0.08,
                              height: screenSize.width * 0.08,
                            ),
                            SizedBox(
                              width: screenSize.width * 0.04,
                            ),
                            Text(
                              widget.medecin!.getEmail(),
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: screenSize.height * 0.02,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //-------------------------------------

                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, screenSize.width * 0.05, 0),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/surgery_icon.png',
                                width: screenSize.width * 0.08,
                                height: screenSize.width * 0.08,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.04,
                              ),
                              Text(
                                widget.medecin!.getSpecialite()??"Not mentioned",
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: screenSize.height * 0.02,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenSize.width * 0.15,
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/attendence.png',
                                width: screenSize.width * 0.08,
                                height: screenSize.width * 0.08,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.04,
                              ),
                              Text(
                                widget.medecin!.getAttendence()??
                                "Not mentioned",
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: screenSize.height * 0.02,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Professional Career',
                        style: TextStyle(
                          color: Color(0xFF66B3FF),
                          fontSize: screenSize.height * 0.03,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald',
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.015,
                      ),
                      Container(
                        height: screenSize.height * 0.2,
                        width: screenSize.width * 0.85,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.medecin!.getProfessionalCarrer()??"Not mentionned",
                                style: TextStyle(
                                  color: Color(0xFFC9C9C9),
                                  fontSize: screenSize.height * 0.015,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                ],
              ),
            ),
            Container(
              width: screenSize.width * 0.45,
              height: screenSize.height * 0.06,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Color(0xFFD37777);
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenSize.width * 0.1),
                    ),
                  ),
                ),
                onPressed: () async {
                  Medecin? m = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrEditProfile(
                              medecin: widget.medecin,
                            )),
                  );
                  if (m != null) {
                    setState(() {
                      widget.medecin = m;
                    });
                    //update the doctor on firestore
                    DatabaseService.updateDoctor(widget.medecin);
                  }
                },
                child: Text(
                  'SET INFO',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Oswald',
                    fontSize: screenSize.height * 0.027,
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
