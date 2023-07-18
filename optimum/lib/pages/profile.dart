import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/edit_pesonal_profile_page.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/menu.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:optimum/shared/loading.dart';

class Profile extends StatefulWidget {
  Patient? patient;
  Profile({super.key, required this.patient});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = AuthService.getAuth().currentUser;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menu.png'),
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
                        backgroundColor: Colors.grey[100],
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
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.white;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenSize.width * 0.15),
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/images/profil_pic.png',
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.015,
            ),
            Text(
              '${widget.patient!.getName()} ${widget.patient!.getLastName()}',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: screenSize.height * 0.04,
                color: Colors.black,
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
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(screenSize.width * 0.01, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    widget.patient!.getPhone() ??
                                        "Not mentionned",
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenSize.height * 0.013,
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/schedule_icon.png',
                                    width: screenSize.width * 0.1,
                                    height: screenSize.width * 0.1,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.02,
                                  ),
                                  Text(
                                    (widget.patient!
                                                    .getDateBirth()
                                                    .toString() ==
                                                "" ||
                                            widget.patient!.getDateBirth() ==
                                                null)
                                        ? "Not mentionned"
                                        : widget.patient!
                                            .getDateBirth()
                                            .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenSize.width * 0.15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
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
                                    widget.patient!.getEmail(),
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenSize.height * 0.015,
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/location_icon.png',
                                    width: screenSize.width * 0.08,
                                    height: screenSize.width * 0.08,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.04,
                                  ),
                                  Text(
                                    widget.patient!.getLocation() ??
                                        "Not mentionned",
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
                          EdgeInsets.fromLTRB(screenSize.width * 0.01, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/bloodtype_icon.png',
                                    width: screenSize.width * 0.08,
                                    height: screenSize.width * 0.08,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.04,
                                  ),
                                  Text(
                                    widget.patient!.getPhone() ??
                                        widget.patient!.getBloodType() ??
                                        "Not mentionned",
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenSize.height * 0.013,
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/allergie_icon.png',
                                    width: screenSize.width * 0.1,
                                    height: screenSize.width * 0.1,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.02,
                                  ),
                                  Text(
                                    widget.patient!.getBloodType() ??
                                        "Not mentionned",
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenSize.width * 0.15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/weight_icon.png',
                                    width: screenSize.width * 0.08,
                                    height: screenSize.width * 0.08,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.04,
                                  ),
                                  Text(
                                    widget.patient!.getBloodType() ??
                                        "Not mentionned",
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenSize.height * 0.015,
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/height_icon.png',
                                    width: screenSize.width * 0.08,
                                    height: screenSize.width * 0.08,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.04,
                                  ),
                                  Text(
                                    widget.patient!.getBloodType() ??
                                        "Not mentionned",
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0.03*screenSize.height,),
                  Container(
                    height: screenSize.height * 0.22,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenSize.height * 0.01, 0, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [Row(
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
                                      'Surgery:',
                                      style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: screenSize.height * 0.02,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.015,
                                ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (widget.patient!.getSurgery()!=null)?
                              widget.patient!.getSurgery()!.map((item){
                                return Column(
                                  children: [
                                    Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      screenSize.width * 0.085, 0, 0, 0),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                if(item!=widget.patient!.getSurgery()!.last) SizedBox(
                                  height: screenSize.height * 0.015,
                                ),
                                  ],
                                );
                              }).toList(): [const Text("Not mentionned")],
                            ),],
                            ),
                            SizedBox(
                              width: screenSize.width * 0.13,
                            ),
                            Container(
                              width: 0.6,
                              height: screenSize.height * 0.3,
                              color: Colors.grey[500],
                            ),
                            SizedBox(
                              width: screenSize.width * 0.07,
                            ),
                            Column(
                              children: [
                                  Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/disease_icon.png',
                                      width: screenSize.width * 0.08,
                                      height: screenSize.width * 0.08,
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.04,
                                    ),
                                    Text(
                                      'Chronic Disease:',
                                      style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: screenSize.height * 0.02,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.015,
                                ),
                            Column(
                              children: (widget.patient!.getCronicDesease()!=null)?
                              widget.patient!.getSurgery()!.map((item){
                                return Column(
                                  children: [
                                    Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      screenSize.width * 0.085, 0, 0, 0),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                if(item!=widget.patient!.getCronicDesease()!.last) SizedBox(
                                  height: screenSize.height * 0.015,
                                ),
                                  ],
                                );
                              }).toList(): [const Text("Not mentionned")],
                            ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.015,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Editpersonal()),
                  );
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