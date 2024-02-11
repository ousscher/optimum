import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/edit_medical_profile_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../provider/theme_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';

class Editpersonal extends StatefulWidget {
  final Patient? malade;
  final Function toggleview;
  final Function(Patient) updateUser;
  Editpersonal(
      {super.key,
      required this.toggleview,
      required this.updateUser,
      required this.malade});

  @override
  State<Editpersonal> createState() => _EditpersonalState();
}

class _EditpersonalState extends State<Editpersonal> {
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
      String userId = widget.malade!.getUid();

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
        widget.malade!.setUrlPhoto(photoURL);
      });
      print(widget.malade!.getUrlPhoto());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'profilePhotoURL': photoURL});
    }
  }
  //------------------fin des fonctions d'images

  String? selectedDateText;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        selectedDateText = formattedDate;
      });
      // Print the date selected
      print('Date selected: $selectedDateText');
    }
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

  String firstName  = "";
  String lastName = "";
  String phoneNB = "";
  String adress = "";
  String error = '';
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = widget.malade!.getName();
    lastName = widget.malade!.getLastName();
    phoneNB = widget.malade!.getPhone() ?? "";
    adress = widget.malade!.getAdress() ?? "";
    selectedDateText = widget.malade!.getDateBirth() ?? "";
  }

  Widget build(BuildContext context) {
    print(widget.malade!.getDateBirth());
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
                              Patient? p = Patient(
                                uid: widget.malade!.getUid(),
                                patientName: firstName,
                                patientLastName: lastName ,
                                gender: widget.malade!.getGender(),
                                urlPhoto: widget.malade!.getUrlPhoto(),
                                patientEmail: widget.malade!.getEmail(),
                                height: widget.malade!.getHeight(),
                                weight: widget.malade!.getWeight(),
                                bloodType: widget.malade!.getBloodType(),
                                cronicDesease:
                                    widget.malade!.getCronicDesease(),
                                surgery: widget.malade!.getSurgery(),
                                alergic: widget.malade!.getAlergic(),
                              );
                              p.setPhone(phoneNB);
                              p.setAdress(adress);
                              p.setDateBirth(selectedDateText);
                              p.setAdress(adress);
                              widget.updateUser(p);
                              widget.toggleview();
                            }
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                'NEXT',
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
                        image: widget.malade!.getUrlPhoto() == null
                            ? AssetImage('assets/images/profil_pic.png')
                            : Image.network(widget.malade!.getUrlPhoto()!)
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
              Text(
                'Fill In This Form So The Dr Can Contact You',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: screenSize.height * 0.02,
                  letterSpacing: 1.0,
                  color: Color(0xFFD9D9D9),
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
              SizedBox(height: screenSize.height * 0.0235),
              Row(
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
                                    firstName  = value;
                                  });
                                  firstName  = firstName .trim();
                                },
                                initialValue: widget.malade!.getName(),
                                decoration: InputDecoration(
                                  hintText: 'First Name',
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
                                onChanged: (value) {
                                  setState(() {
                                    lastName = value;
                                  });
                                  lastName = lastName.trim();
                                },
                                validator: (value) => validateName(value!),
                                initialValue: widget.malade!.getLastName(),
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
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
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Date Of Birth',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: screenSize.height * 0.023,
                                color: Color(0xFF66B3FF),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Container(
                                width: screenSize.width * 0.6,
                                height: screenSize.height * 0.068,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  color: Colors.grey.shade50,
                                  border: Border.all(
                                    color: Color(
                                        0xFFD9D9D9), // Set the border color to black
                                    width: 1.0, // Set the border width
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: screenSize.width * 0.25),
                                    child: Text(
                                      selectedDateText ?? 'Not Mentioned',
                                      // style: TextStyle(
                                      //   fontSize: screenSize.width * 0.045,
                                      // ),
                                    ),
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
                              'Phone Nb',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: screenSize.height * 0.023,
                                color: Color(0xFF66B3FF),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.07,
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
                                initialValue: widget.malade!.getPhone() ?? "",
                                decoration: InputDecoration(
                                  hintText: 'Phone Nb',
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
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Address',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: screenSize.height * 0.023,
                                color: Color(0xFF66B3FF),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.1,
                            ),
                            Container(
                              width: screenSize.width * 0.6,
                              height: screenSize.height * 0.068,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.grey.shade50,
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    adress = value;
                                  });
                                  adress = adress.trim();
                                },
                                //peut etre qu'on  aura besoin d'un validateur du champs adress
                                initialValue: widget.malade!.getAdress() ?? "",
                                decoration: InputDecoration(
                                  hintText: 'Address',
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
                        SizedBox(
                          height: screenSize.height * 0.08,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
