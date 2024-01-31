import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import 'editChanger.dart';

class Profile extends StatefulWidget {
  Patient? patient;
  Profile({super.key, required this.patient});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  final user = AuthService.getAuth().currentUser;

  @override
  
  Widget build(BuildContext context) {
    Future<Uint8List?> downloadImage(String imageUrl) async {
    // Votre code de téléchargement d'image ici...

  }
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
                          Navigator.pop(context, widget.patient);
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
                child:
                  (widget.patient!.getUrlPhoto() !=null)?
                  ClipOval(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/profil_pic.png'), // Image de remplacement pendant le chargement.
                      image:NetworkImage(widget.patient!.getUrlPhoto()!)  ,
                      fit: BoxFit.cover,
                      ),
                  ):Image(image: AssetImage("assets/images/profil_pic.png"))),
            SizedBox(
              height: screenSize.height * 0.015,
            ),
            Text(
              '${widget.patient!.getName()} ${widget.patient!.getLastName()}',
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
                                        "Not mentioned",
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Theme.of(context).primaryColor,
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
                                    (widget.patient!.getDateBirth() == "" ||
                                            widget.patient!.getDateBirth() ==
                                                null)
                                        ? "Not mentioned"
                                        : widget.patient!.getDateBirth()!,
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
                                      color: Theme.of(context).primaryColor,
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
                                    widget.patient!.getAdress() ??
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
                          EdgeInsets.fromLTRB(0, 0, screenSize.width * 0.05, 0),
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
                                    widget.patient!.getBloodType() ??
                                        "Not mentioned",
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Theme.of(context).primaryColor,
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
                                    (widget.patient!.getAlergic() == null)
                                        ? "Not mentioned"
                                        : widget.patient!.getAlergic()!,
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
                                    (widget.patient!.getWeight() == null || widget.patient!.getWeight()=="" )
                                        ? "Not mentioned"
                                        : ("${widget.patient!.getWeight()}  KG"),
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Theme.of(context).primaryColor,
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
                                    (widget.patient!.getHeight() == null || widget.patient!.getHeight()=="")
                                        ? "Not mentioned"
                                        : ("${widget.patient!.getHeight()}  CM"),
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
                    height: screenSize.height * 0.01,
                  ),
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
                              children: [
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
                                      'Surgery:',
                                      style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: screenSize.height * 0.02,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.015,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: (widget.patient!.getSurgery() !=
                                          null)
                                      ? widget.patient!
                                          .getSurgery()!
                                          .map((item) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    screenSize.width * 0.085,
                                                    0,
                                                    0,
                                                    0),
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontSize:
                                                        screenSize.height *
                                                            0.02,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              if (item !=
                                                  widget.patient!
                                                      .getSurgery()!
                                                      .last)
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.015,
                                                ),
                                            ],
                                          );
                                        }).toList()
                                      : [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: screenSize.width * 0.05,
                                              ),
                                              Text(
                                                "Not mentioned",
                                                style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                  fontSize:
                                                      screenSize.height * 0.02,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: screenSize.width * 0.15,
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.015,
                                ),
                                Column(
                                  children: (widget.patient!
                                              .getCronicDesease() !=
                                          null)
                                      ? widget.patient!
                                          .getSurgery()!
                                          .map((item) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    screenSize.width * 0.085,
                                                    0,
                                                    0,
                                                    0),
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontSize:
                                                        screenSize.height *
                                                            0.02,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              if (item !=
                                                  widget.patient!
                                                      .getCronicDesease()!
                                                      .last)
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.015,
                                                ),
                                            ],
                                          );
                                        }).toList()
                                      : [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: screenSize.width * 0.03,
                                              ),
                                              Text(
                                                "Not mentioned",
                                                style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                  fontSize:
                                                      screenSize.height * 0.02,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
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
                onPressed: () async {
                  print(widget.patient!.getBloodType());
                  Patient? p = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditChanger(
                              malade: widget.patient,
                            )),
                  );
                  if (p != null) {
                    setState(() {
                      widget.patient = p;
                    });
                    //update the user on firestore
                    DatabaseService.updateUser(widget.patient);
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
