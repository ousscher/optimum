import 'package:flutter/material.dart';
import 'package:optimum/pages/edit_pesonal_profile_page.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/menu.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                      padding: EdgeInsets.fromLTRB(screenSize.width * 0.06, screenSize.height * 0.06, 0, 0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) => Menu()),
                          );
                        },// Menu button
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFFD37777),
                        ),
                        backgroundColor: Colors.grey[100],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.06,),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.136, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height * 0.06,),
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
                      borderRadius: BorderRadius.circular(screenSize.width * 0.15),
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
            SizedBox(height: screenSize.height * 0.015,),
            Text(
              'Soltani Amine',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: screenSize.height * 0.04,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.height * 0.01, 0, screenSize.height * 0.01, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height * 0.03,),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(height: screenSize.height * 0.01,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.01, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/phone_icon.png',
                                width: screenSize.width * 0.08 ,
                                height: screenSize.width * 0.08 ,
                              ),
                              SizedBox(width: screenSize.width * 0.04,),
                              Text(
                                '07 34 66 55 01',
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: screenSize.height * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.013,),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/schedule_icon.png',
                                width: screenSize.width * 0.1 ,
                                height: screenSize.width * 0.1 ,
                              ),
                              SizedBox(width: screenSize.width * 0.02,),
                              Text(
                                '22 JULY 2003',
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
                      SizedBox(width: screenSize.width * 0.15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/email_icon.png',
                                width: screenSize.width * 0.08 ,
                                height: screenSize.width * 0.08 ,
                              ),
                              SizedBox(width: screenSize.width * 0.04,),
                              Text(
                                'lm_soltani@esi.dz',
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: screenSize.height * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: screenSize.height * 0.015,),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/location_icon.png',
                                width: screenSize.width * 0.08 ,
                                height: screenSize.width * 0.08,
                              ),
                              SizedBox(width: screenSize.width * 0.04,),
                              Text(
                                'Biskra, Algeria',
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
              SizedBox(height: screenSize.height * 0.01,),
              Divider(
                height: screenSize.height * 0.01,
                color: Colors.grey[500],
              ),
              SizedBox(height: screenSize.height * 0.01,),
              Padding(
                padding: EdgeInsets.fromLTRB(screenSize.height * 0.01, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/bloodtype_icon.png',
                              width: screenSize.width * 0.08 ,
                              height: screenSize.width * 0.08 ,
                            ),
                            SizedBox(width: screenSize.width * 0.04,),
                            Text(
                              'O+',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: screenSize.height * 0.02,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.015,),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/allergie_icon.png',
                              width: screenSize.width * 0.08 ,
                              height: screenSize.width * 0.08 ,
                            ),
                            SizedBox(width: screenSize.width * 0.04,),
                            Text(
                              'Allergic',
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
                    SizedBox(width: screenSize.width * 0.275,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/weight_icon.png',
                              width: screenSize.width * 0.08 ,
                              height: screenSize.width * 0.08 ,
                            ),
                            SizedBox(width: screenSize.width * 0.04,),
                            Text(
                              '60 KG',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: screenSize.height * 0.02,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.015,),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/height_icon.png',
                              width: screenSize.width * 0.08 ,
                              height: screenSize.width * 0.08,
                            ),
                            SizedBox(width: screenSize.width * 0.04,),
                            Text(
                              '185 CM',
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
              SizedBox(height: screenSize.height * 0.01,),
              Divider(
                height: screenSize.height * 0.01,
                color: Colors.grey[500],
              ),
              SizedBox(height: screenSize.height * 0.01,),

              Container(
                height: screenSize.height * 0.22,
                child: SingleChildScrollView(
                  child: Padding(
                        padding: EdgeInsets.fromLTRB(screenSize.height * 0.01, 0, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/surgery_icon.png',
                                      width: screenSize.width * 0.08 ,
                                      height: screenSize.width * 0.08 ,
                                    ),
                                    SizedBox(width: screenSize.width * 0.04,),
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
                                SizedBox(height: screenSize.height * 0.015,),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(screenSize.width * 0.085, 0, 0, 0),
                                    child: Text(
                                      'Not Mentioned',
                                      style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: screenSize.height * 0.02,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: screenSize.height * 0.015,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.085, 0, 0, 0),
                                  child: Text(
                                    'Not Mentioned',
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenSize.height * 0.015,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.085, 0, 0, 0),
                                  child: Text(
                                    'Not Mentioned',
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenSize.height * 0.015,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.085, 0, 0, 0),
                                  child: Text(
                                    'Not Mentioned',
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenSize.height * 0.015,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.085, 0, 0, 0),
                                  child: Text(
                                    'Not Mentioned',
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenSize.height * 0.015,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.085, 0, 0, 0),
                                  child: Text(
                                    'Not Mentioned',
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                ],
                            ),
                            SizedBox(width: screenSize.width * 0.13,),
                            Container(
                              width: 0.6,
                              height: screenSize.height * 0.3,
                              color: Colors.grey[500],
                            ),
                            SizedBox(width: screenSize.width * 0.07,),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/disease_icon.png',
                                      width: screenSize.width * 0.08 ,
                                      height: screenSize.width * 0.08 ,
                                    ),
                                    SizedBox(width: screenSize.width * 0.04,),
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
                                SizedBox(height: screenSize.height * 0.015,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.085, 0, 0, 0),
                                  child: Text(
                                    'Not Mentioned',
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: screenSize.height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                  ],
                            ),
                          ],
                        ),
                      ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.015,),
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
                      borderRadius: BorderRadius.circular(screenSize.width * 0.1),
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
