import 'package:flutter/material.dart';
import 'package:optimum/pages/edit_medical_profile_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

import '../provider/theme_provider.dart';

class DrEditProfile extends StatefulWidget {
  // final Patient malad;
  //final Function toggleview;
  DrEditProfile({super.key, /*required this.toggleview*/});

  @override
  State<DrEditProfile> createState() => _DrEditProfileState();
}

class _DrEditProfileState extends State<DrEditProfile> {
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
                            //widget.toggleview();
                            Navigator.pop(
                              context,
                            );
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
                          Padding(
                            padding: EdgeInsets.only(left: screenSize.width * 0.04),
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
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Email',
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
                          Padding(
                            padding: EdgeInsets.only(right: screenSize.width * 0.02),
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
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Speciality',
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
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: screenSize.width *0.03),
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
                                SizedBox(width: screenSize.width * 0.01,),
                                Container(
                                  width: screenSize.width * 0.6,
                                  height: screenSize.height * 0.068,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFD9D9D9)),
                                    borderRadius: BorderRadius.circular(40.0),
                                    color: Colors.grey.shade50,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyDropdownPage(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: screenSize.width * 0.44),
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
                            child: TextField(
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


  MyDropdownPage( {super.key});
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
            hint: Text('Attendance'),
          ),
        ),
      ),
    );
  }
}