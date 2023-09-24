import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optimum/pages/edit_medical_profile_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

import '../provider/theme_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DrEditProfile extends StatefulWidget {
  // final Patient malad;
  //final Function toggleview;
  Medecin? medecin;
  DrEditProfile({
    super.key,
    required this.medecin,
    /*required this.toggleview*/
  });

  @override
  State<DrEditProfile> createState() => _DrEditProfileState();
}

class _DrEditProfileState extends State<DrEditProfile> {

  //le traitement d'image of user
  File? _image;
  String? url;
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
      String userId = widget.medecin!.getUid();

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
        widget.medecin!.setUrlPhoto(photoURL);
      });
      await FirebaseFirestore.instance
          .collection('meds')
          .doc(userId)
          .update({'profilePhotoURL': photoURL});
    }
  }
  //------------------fin des fonctions d'images


  final _formKey = GlobalKey<FormState>();

  String name = "";
  String lastName = "";
  String email = "";
  String phoneNB = "";
  String specialite = "";
  String professionalCarrer = "";
  String? validateEmail(String value) {
    value = value.trim();
    if (value != null &&
        !RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
            .hasMatch(value)) {
      return 'Adresse e-mail invalide';
    }
    return null;
  }

  String? validateName(String value) {
    String trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Please verify your name and lastname';
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) return null;
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Le numéro de téléphone ne doit contenir que des chiffres.';
    }

    if (value.length != 10) {
      return 'Le numéro de téléphone doit avoir exactement 10 chiffres.';
    }

    return null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.medecin!.getName();
    lastName = widget.medecin!.getLastName();
    email = widget.medecin!.getEmail();
    phoneNB =
        (widget.medecin!.getPhone() == null) ? "" : widget.medecin!.getPhone()!;
    specialite = widget.medecin!.getSpecialite() == null
        ? ""
        : widget.medecin!.getSpecialite()!;
    professionalCarrer = widget.medecin!.getProfessionalCarrer() == null
        ? ""
        : widget.medecin!.getProfessionalCarrer()!;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'edit_profile_dark'
        : 'edit_profile';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/' + '$img' + '.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, screenSize.height * 0.04, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.navigate_before,
                                color: Color(0xFFD37777),
                                size: 30.0,
                              ),
                              Text(
                                'BACK',
                                style: TextStyle(
                                  color: Color(0xFFD37777),
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.08,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(screenSize.width * 0.02, 0, 0, 0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: screenSize.height * 0.06,
                        ),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: screenSize.height * 0.0579,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, screenSize.height * 0.04, 0, 0),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print(name);
                              setState(() {
                                widget.medecin!.setName(name);
                                widget.medecin!.setLastName(lastName);
                                widget.medecin!.setEmail(email);
                                widget.medecin!.setPhone(phoneNB);
                                specialite==""? widget.medecin!.setSpecialite(null): widget.medecin!.setSpecialite(specialite);
                                professionalCarrer==""? widget.medecin!.setProfessionalCarrer(null):widget.medecin!.setProfessionalCarrer(professionalCarrer);
                              });
                              Navigator.pop(context, widget.medecin);
                            }
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                'DONE',
                                style: TextStyle(
                                  color: Color(0xFFD37777),
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
                                ),
                              ),
                              Icon(
                                Icons.navigate_next_sharp,
                                color: Color(0xFFD37777),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.08,
                      ),
                    ],
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
                    image: DecorationImage(
                        image: widget.medecin!.getUrlPhoto() == null
                            ? AssetImage('assets/images/profil_pic.png')
                            : Image.network(widget.medecin!.getUrlPhoto()!)
                                .image,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  getImageFromGallery();
                },
                child: Text(
                  'Edit Picture',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: screenSize.height * 0.018,
                    letterSpacing: 2.0,
                    color: Color(0xFF66B3FF),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenSize.width * 0.05, 0, screenSize.width * 0.05, 0),
                child: Divider(
                  height: screenSize.height * 0.01,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.007,
              ),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: screenSize.height * 0.03,
                  letterSpacing: 1.0,
                  color: Color(0xFFD37777),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.007,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenSize.width * 0.05, 0, screenSize.width * 0.05, 0),
                child: Divider(
                  height: screenSize.height * 0.01,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Container(
                height: screenSize.height * 0.46,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'First Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: screenSize.height * 0.023,
                                    color: Color(0xFF66B3FF),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.06,
                                ),
                                Container(
                                  width: screenSize.width * 0.6,
                                  height: screenSize.height * 0.068,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.0),
                                    color: Colors.grey.shade50,
                                  ),
                                  child: TextFormField(
                                    validator: (value) => validateName(value!),
                                    onChanged: (value) {
                                      setState(() {
                                        name = value;
                                      });
                                      name = name.trim();
                                      print(name);
                                    },
                                    initialValue: name,
                                    decoration: InputDecoration(
                                      hintText: 'First Name',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Last Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: screenSize.height * 0.023,
                                    color: Color(0xFF66B3FF),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.06,
                                ),
                                Container(
                                  width: screenSize.width * 0.6,
                                  height: screenSize.height * 0.068,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.0),
                                    color: Colors.grey.shade50,
                                  ),
                                  child: TextFormField(
                                    validator: (value) => validateName(value!),
                                    onChanged: (value) {
                                      setState(() {
                                        lastName = value;
                                      });
                                      lastName = lastName.trim();
                                    },
                                    initialValue: lastName,
                                    decoration: InputDecoration(
                                      hintText: 'Last Name',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.width * 0.04),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: screenSize.height * 0.023,
                                      color: Color(0xFF66B3FF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.13,
                                  ),
                                  Container(
                                    width: screenSize.width * 0.6,
                                    height: screenSize.height * 0.068,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: TextFormField(
                                      validator: (value) =>
                                          validateEmail(value!),
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                        email = email.trim();
                                      },
                                      initialValue: email,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                              color: Color(0xFFD9D9D9)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                              color: Color(0xFFD9D9D9)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                              color: Color(0xFFD9D9D9)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Phone Nb',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: screenSize.height * 0.023,
                                    color: Color(0xFF66B3FF),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.06,
                                ),
                                Container(
                                  width: screenSize.width * 0.6,
                                  height: screenSize.height * 0.068,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.0),
                                    color: Colors.grey.shade50,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {
                                      setState(() {
                                        phoneNB = value;
                                      });
                                      phoneNB = phoneNB.trim();
                                    },
                                    validator: (value) =>
                                        validatePhoneNumber(value!),
                                    initialValue: phoneNB,
                                    decoration: InputDecoration(
                                      hintText: 'Phone Nb',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenSize.width * 0.02),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Speciality',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: screenSize.height * 0.023,
                                      color: Color(0xFF66B3FF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.06,
                                  ),
                                  Container(
                                    width: screenSize.width * 0.6,
                                    height: screenSize.height * 0.068,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: TextFormField(
                                      initialValue: specialite,
                                      onChanged: (value) {
                                        setState(() {
                                          specialite = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Speciality',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                              color: Color(0xFFD9D9D9)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                              color: Color(0xFFD9D9D9)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                              color: Color(0xFFD9D9D9)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenSize.width * 0.03),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Attendance',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: screenSize.height * 0.023,
                                      color: Color(0xFF66B3FF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.01,
                                  ),
                                  Container(
                                    width: screenSize.width * 0.6,
                                    height: screenSize.height * 0.068,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFD9D9D9)),
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MyDropdownPage(
                                        med: widget.medecin,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenSize.width * 0.44),
                              child: Text(
                                'Professional Career',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: screenSize.height * 0.023,
                                  color: Color(0xFF66B3FF),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Container(
                              width: screenSize.width * 0.9,
                              height: screenSize.height * 0.068,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.grey.shade50,
                              ),
                              child: TextFormField(
                                initialValue: professionalCarrer,
                                onChanged: (value) {
                                  setState(() {
                                    professionalCarrer = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Professional career',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFFD9D9D9)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFFD9D9D9)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFFD9D9D9)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.079,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDropdownPage extends StatefulWidget {
  Medecin? med;
  MyDropdownPage({super.key, required this.med});
  @override
  _MyDropdownPageState createState() => _MyDropdownPageState();
}

class _MyDropdownPageState extends State<MyDropdownPage> {
  String? _dropdownValue;
  static const list1 = [
    DropdownMenuItem(child: Text("Present"), value: "Present"),
    DropdownMenuItem(child: Text("Absent"), value: "Absent"),
  ];

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
        if (selectedValue == "Not Mentioned") {
          widget.med!.setAttendence(null);
        } else
          widget.med!.setAttendence(selectedValue);
      });

      // Print the selected value

      print("Selected value: $_dropdownValue");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
          child: DropdownButton(
            items: list1,
            value: _dropdownValue,
            onChanged: dropdownCallback,
            isExpanded: true,
            borderRadius: BorderRadius.circular(20.0),
            iconEnabledColor: Color(0xFFD37777),
            iconSize: 26.0,
            icon: Icon(
              Icons.arrow_drop_down_circle_outlined,
              color: Color(0xFFD37777),
            ),
            hint: widget.med!.getAttendence() == null
                ? Text("Not Mentionned")
                : Text("${widget.med!.getAttendence()}"),
          ),
        ),
      ),
    );
  }
}
