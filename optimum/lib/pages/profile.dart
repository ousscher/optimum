import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/editChanger.dart';
import 'package:optimum/pages/edit_pesonal_profile_page.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/menu.dart';
import 'package:optimum/services/auth.dart';
import 'package:optimum/services/database.dart';
import 'package:optimum/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../provider/theme_provider.dart';

class Profile extends StatefulWidget {
  Patient? patient;
  Profile({super.key, required this.patient});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override

  //le traitement d'image of user
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Aucune image sélectionnée.');
      }
    });
    uploadImage();
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      // Obtenir l'ID de l'utilisateur actuellement connecté, ou utilisez l'ID de l'utilisateur d'où vous obtenez les informations utilisateur
      String userId = widget.patient!.getUid();

      // Upload de l'image vers Firebase Storage
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('profile_photos')
          .child('$userId.jpg');

      firebase_storage.UploadTask uploadTask =
          storageReference.putFile(_image!);

      await uploadTask;

      // Récupérer l'URL de téléchargement de l'image
      String photoURL = await storageReference.getDownloadURL();

      // Mettre à jour l'utilisateur avec le nouvel URL de la photo de profil dans Firestore
      setState(() {
        widget.patient!.setUrlPhoto(photoURL);
      });
      print(widget.patient!.getUrlPhoto());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'profilePhotoURL': photoURL});
    }
  }
  //------------------fin des fonctions d'images

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
                          Navigator.pop(context , widget.patient);
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
            InkWell(
              onTap: () {
                    getImageFromGallery();
                  },
              child: Container(
                width: screenSize.width * 0.26,
                height: screenSize.width * 0.26,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                  border: Border.all(
                    width: 2.0,
                    color: Color(0xFFD37777),
                  ),
                  shape: BoxShape.circle,
                  image:DecorationImage(
                    image: widget.patient!.getUrlPhoto() == null
                    ? AssetImage('assets/images/profil_pic.png')
                    :Image.network(widget.patient!.getUrlPhoto()!).image,
                    fit: BoxFit.cover
                  ),
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
                                    (widget.patient!
                                                    .getDateBirth()
                                                    .toString() ==
                                                "" ||
                                            widget.patient!.getDateBirth() ==
                                                null)
                                        ? "Not mentioned"
                                        : widget.patient!
                                            .getDateBirth()
                                            .toString(),
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
                                        : (widget.patient!.getAlergic()!)
                                            ? "alergic"
                                            : "Not Alergic",
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
                                    (widget.patient!.getWeight() == null)
                                        ? "Not mentioned"
                                        : widget.patient!
                                            .getWeight()
                                            .toString(),
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
                                    (widget.patient!.getHeight() == null)
                                        ? "Not mentioned"
                                        : widget.patient!
                                            .getHeight()
                                            .toString(),
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
