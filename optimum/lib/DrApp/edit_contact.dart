import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class Editcontact extends StatefulWidget {
  const Editcontact({super.key});

  @override
  State<Editcontact> createState() => _EditcontactState();
}

class _EditcontactState extends State<Editcontact> {

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fontSize: screenSize.width * 0.058,
                                  fontFamily: 'Oswald',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),

                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, screenSize.height * 0.04, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            //widget.toggleview();
                            Navigator.pop(context,);
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                'DONE',
                                style: TextStyle(
                                  color: Color(0xFFD37777),
                                  fontSize: screenSize.width * 0.058,
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

                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.0,
              ),
              Text(
                'Edit Contact',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: screenSize.width * 0.12,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenSize.height * 0.13,),
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
                'Contact Information',
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
              SizedBox(height: screenSize.height * 0.04),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
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
                          Padding(
                            padding: EdgeInsets.only(left: screenSize.width * 0.01),
                            child: Row(
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
                                  width: screenSize.width * 0.09,
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
                                  'Facebook',
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
                                      hintText: 'Facebook',
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
                            padding: EdgeInsets.only(right: screenSize.width * 0.025),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Instagram',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: screenSize.height * 0.023,
                                    color: Color(0xFF66B3FF),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.05,
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
                                      hintText: 'Instagram',
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
                    ],
                  ),
              SizedBox(
                height: screenSize.height * 0.148,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
