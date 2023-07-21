import 'package:flutter/material.dart';
import 'package:optimum/pages/edit_medical_profile_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'package:intl/intl.dart';
import '../provider/theme_provider.dart';

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

  String prenom = "";
  String nom = "";
  String dateOfBirth = "";
  String phoneNB = "";
  String adress = "";
  String error = '';
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prenom = widget.malade!.getName();
    nom = widget.malade!.getLastName();
    dateOfBirth = (widget.malade!.getDateBirth().toString() == "" ||
        widget.malade!.getDateBirth() == null)
        ? ""
        : widget.malade!.getDateBirth().toString();
    phoneNB = widget.malade!.getPhone() ?? "";
    adress = widget.malade!.getAdress() ?? "";
  }
    Widget build(BuildContext context) {
      final screenSize = MediaQuery
          .of(context)
          .size;
      final img = Provider
          .of<ThemeProvider>(context)
          .themeMode == ThemeMode.light
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
                                    patientName: nom,
                                    patientLastName: prenom,
                                    patientEmail: widget.malade!.getEmail());
                                p.setPhone(phoneNB);
                                p.setAdress(adress);
                                print(adress);
                                print(p.getAdress());
                                //set the date birth apres le settings du form de DatePicker
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
                Container(
                  width: screenSize.width * 0.26,
                  height: screenSize.width * 0.26,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.grey.shade300;
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(screenSize.width * 0.15),
                          side: BorderSide(
                            width: 2.0,
                            color: Color(0xFFD37777),
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
                TextButton(
                  onPressed: () {},
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
                                      prenom = value;
                                    });
                                    prenom = prenom.trim();
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
                                      nom = value;
                                    });
                                    nom = nom.trim();
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
                                      color: Color(0xFFD9D9D9), // Set the border color to black
                                      width: 1.0, // Set the border width
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding:EdgeInsets.only(right: screenSize.width * 0.25),
                                      child: Text(
                                        selectedDateText ?? 'Not Mentioned',
                                        style: TextStyle(
                                          fontSize: screenSize.width * 0.045,
                                        ),
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
                                child:  TextFormField(
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

