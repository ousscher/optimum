import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/pages/verifyUser.dart';
import 'package:optimum/services/auth.dart';
import 'package:provider/provider.dart';

import '../shared/loading.dart';

class Createaccount extends StatefulWidget {
  final Function toggleView;
  Createaccount({required this.toggleView});

  @override
  State<Createaccount> createState() => _CreateaccountState();
}
  
class _CreateaccountState extends State<Createaccount> {
  final _formKey = GlobalKey<FormState>();

  String nom = '';
  String prenom = '';
  String email = '';
  String password = '';
  String confirmPasswd = '';
  String error = '';
  bool loading = false;

  String? validateName(String value) {
    String trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Veuillez entrer votre prénom.';
    }
    return null;
  }

  String? validateLastName(String value) {
    String trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Veuillez entrer votre nom.';
    }
    return null;
  }

  String? validateEmail(String value) {
    value = value.trim();
    if (value != null &&
        !RegExp(
            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
            .hasMatch(value)) {
      return 'Adresse e-mail invalide';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != password) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return loading ? Loading() : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sign.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.04,
              screenHeight * 0.29,
              screenWidth * 0.04,
              0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      0,
                      screenWidth * 0.3,
                      0,
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Color(0xFF66B3FF),
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontFamily: 'Oswald',
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.05,
                      0,
                      screenWidth * 0.05,
                      0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: screenHeight * 0.456,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: screenWidth * 0.85,
                                    height: screenHeight * 0.075,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(40.0),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          prenom = value;
                                        });
                                        prenom = prenom.trim();
                                      },
                                      validator: (value) {
                                        return validateName(value!);
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'First Name',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFD9D9D9),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                            color: Color(0xFFD9D9D9),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              SizedBox(height: screenHeight * 0.02),
                              Container(
                                width: screenWidth * 0.85,
                                height: screenHeight * 0.075,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(40.0),
                                  color: Colors.grey.shade50,
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      nom = value;
                                    });
                                    nom = nom.trim();
                                  },
                                  validator: (value) {
                                    return validateLastName(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                                  Container(
                                    width: screenWidth * 0.85,
                                    height: screenHeight * 0.075,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFD9D9D9)),
                                      borderRadius:
                                      BorderRadius.circular(40.0),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MyDropdownPage(
                                        //patient: widget.malade,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                              Container(
                                width: screenWidth * 0.85,
                                height: screenHeight * 0.075,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(40.0),
                                  color: Colors.grey.shade50,
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                    email = email.trim();
                                  },
                                  validator: (value) {
                                    return validateEmail(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Container(
                                width: screenWidth * 0.85,
                                height: screenHeight * 0.075,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(40.0),
                                  color: Colors.grey.shade50,
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  validator: (value) {
                                    return validatePassword(value!);
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Container(
                                width: screenWidth * 0.85,
                                height: screenHeight * 0.075,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(40.0),
                                  color: Colors.grey.shade50,
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      confirmPasswd = value;
                                    });
                                  },
                                  validator: (value) {
                                    return validateConfirmPassword(value!);
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Confirm Password',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Container(
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.065,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    return Color(0xFFD37777);
                                  },
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                //la validation avant la requete
                                setState(() {
                                  loading = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  dynamic result = await AuthService
                                      .registerWithEmailAndPasswd(
                                      email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = "please supply a valid email";
                                      loading = false;
                                    });
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VerifyUser(name: prenom, lastName: nom , email: email,)),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Create',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Oswald',
                                  fontSize: screenHeight * 0.03,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            error,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'You have Account?',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.043,
                                    fontFamily: 'Poppins',
                                    letterSpacing: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: Color(0xFF66B3FF),
                                      fontSize: screenWidth * 0.043,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyDropdownPage extends StatefulWidget {
  //Patient? patient;
  MyDropdownPage({super.key/*, required this.patient*/});
  @override
  _MyDropdownPageState createState() => _MyDropdownPageState();
}

class _MyDropdownPageState extends State<MyDropdownPage> {
  String? _dropdownValue;
  static const list1 = [
    DropdownMenuItem(child: Text("Not Mentioned"), value: "Not Mentioned"),
    DropdownMenuItem(child: Text("Man"), value: "Man"),
    DropdownMenuItem(child: Text("Woman"), value: "Woman"),
  ];

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      //setState(() {
      //  _dropdownValue = selectedValue;
      //  if (selectedValue == "Not Mentioned") {
      //    widget.patient!.setBloodType(null);
      //  } else
      //    widget.patient!.setBloodType(selectedValue);
      // });

      // Print the selected value

      //print("Selected value: $_dropdownValue");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.patient!.getBloodType());
  }

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
            hint: Text(
              "Gender",
              style: TextStyle(
                color: Color(0xFFD9D9D9),
              ),
            ),
            //    widget.patient!.getBloodType() == null
            //    ? Text("Not Mentionned")
            //    : Text("${widget.patient!.getBloodType()}"),
          ),
        ),
      ),
    );
  }
}
