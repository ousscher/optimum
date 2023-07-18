import 'package:flutter/material.dart';
import 'package:optimum/pages/edit_medical_profile_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

import '../provider/theme_provider.dart';

class Editpersonal extends StatefulWidget {
  // final Patient malad;
  final Function toggleview;
  Editpersonal({super.key, required this.toggleview});

  @override
  State<Editpersonal> createState() => _EditpersonalState();
}

class _EditpersonalState extends State<Editpersonal> {
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
                          onPressed: () {
                            widget.toggleview();
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
                  Column(
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
                            child: TextField(
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
                            child: TextField(
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
                          Container(
                            width: screenSize.width * 0.6,
                            height: screenSize.height * 0.068,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.grey.shade50,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Date Of Birth',
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
                            child: TextField(
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
                            child: TextField(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
