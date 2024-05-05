import 'package:optimum/DrApp/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/clinic.dart';
import 'package:optimum/services/database.dart';
import 'package:optimum/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/theme_provider.dart';

class DrContact extends StatefulWidget {
  const DrContact({super.key});

  @override
  State<DrContact> createState() => _DrContactState();
}

class _DrContactState extends State<DrContact> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'contact_dark'
        : 'contact';

    return Scaffold(
      body: StreamBuilder<Clinic>(
        stream: DatabaseService().clinicData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Clinic? clinic = snapshot.data;
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/' + '$img' + '.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, screenSize.height * 0.06, screenSize.width * 0.7, 0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, // Menu button
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFFD37777),
                      ),
                      backgroundColor: Theme.of(context).shadowColor,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.265),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, 0, screenSize.width * 0.1, 0),
                    child: Text(
                      'Here Are Our Contacts',
                      style: TextStyle(
                        color: Color(0xFF66B3FF),
                        fontFamily: 'Oswald',
                        fontSize: screenSize.height * 0.04,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(screenSize.width * 0.09, 0, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: screenSize.width * 0.15,
                              height: screenSize.width * 0.15,
                              child: TextButton(
                                onPressed: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailUri = Uri(
                                    scheme: 'mailto',
                                    path: clinic!.getEmail(),
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': 'Patient Question',
                                    }),
                                  );
                                  try {
                                    await launchUrl(emailUri);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/email_icon.png',
                                  width: screenSize.width * 0.1,
                                  height: screenSize.height * 0.1,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.grey.shade300;
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenSize.width * 0.15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.06,
                            ),
                            GestureDetector(
                              onTap: () async {
                                String? encodeQueryParameters(
                                    Map<String, String> params) {
                                  return params.entries
                                      .map((MapEntry<String, String> e) =>
                                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                      .join('&');
                                }

                                final Uri emailUri = Uri(
                                  scheme: 'mailto',
                                  path: clinic.getEmail(),
                                  query: encodeQueryParameters(<String, String>{
                                    'subject': 'Patient Question',
                                  }),
                                );
                                try {
                                  await launchUrl(emailUri);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                '${clinic!.getEmail()}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
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
                            Container(
                              width: screenSize.width * 0.15,
                              height: screenSize.width * 0.15,
                              child: TextButton(
                                onPressed: () async {
                                  final Uri phoneUri = Uri(
                                    scheme: 'tel',
                                    path: clinic.getPhone(),
                                  );
                                  try {
                                    await launchUrl(phoneUri);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/phone_icon.png',
                                  width: screenSize.width * 0.07,
                                  height: screenSize.height * 0.07,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.grey.shade300;
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenSize.width * 0.15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.06,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final Uri phoneUri = Uri(
                                  scheme: 'tel',
                                  path: clinic.getPhone(),
                                );
                                try {
                                  await launchUrl(phoneUri);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                '${clinic.getPhone()}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
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
                            Container(
                              width: screenSize.width * 0.15,
                              height: screenSize.width * 0.15,
                              child: TextButton(
                                onPressed: () async {
                                  final Uri mapsUri = Uri(
                                    scheme: 'https',
                                    host: 'www.google.dz',
                                    path: clinic.getLocationLink(),
                                  );
                                  try {
                                    await launchUrl(mapsUri);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/location_icon.png',
                                  width: screenSize.width * 0.07,
                                  height: screenSize.height * 0.07,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.grey.shade300;
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenSize.width * 0.15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.06,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final Uri mapsUri = Uri(
                                  scheme: 'https',
                                  host: 'www.google.dz',
                                  path: clinic.getLocationLink(),
                                );
                                try {
                                  await launchUrl(mapsUri);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                clinic.getAdress(),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
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
                            Container(
                              width: screenSize.width * 0.15,
                              height: screenSize.width * 0.15,
                              child: TextButton(
                                onPressed: () async {
                                  final Uri facebookUri = Uri(
                                    scheme: 'https',
                                    host: 'facebook.com',
                                  );
                                  try {
                                    await launchUrl(facebookUri);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/facebook.png',
                                  width: screenSize.width * 0.1,
                                  height: screenSize.height * 0.1,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.grey.shade300;
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenSize.width * 0.15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.06,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final Uri facebookUri = Uri(
                                  scheme: 'https',
                                  host: 'www.facebook.com',
                                );
                                try {
                                  await launchUrl(facebookUri);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                clinic.getFacebookAccount(),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
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
                            Container(
                              width: screenSize.width * 0.15,
                              height: screenSize.width * 0.15,
                              child: TextButton(
                                onPressed: () async {
                                  final Uri instagramUri = Uri(
                                    scheme: 'https',
                                    host: 'instagram.com',
                                    path: clinic.getFacebookAccount(),
                                  );
                                  try {
                                    await launchUrl(instagramUri);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/instagram.png',
                                  width: screenSize.width * 0.08,
                                  height: screenSize.height * 0.08,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.grey.shade300;
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenSize.width * 0.15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.06,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final Uri instagramUri = Uri(
                                  scheme: 'https',
                                  host: 'instagram.com',
                                  path: clinic.getInstaAccount(),
                                );
                                try {
                                  await launchUrl(instagramUri);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                clinic.getInstaAccount(),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: screenSize.width * 0.1),
                          child: Container(
                            width: screenSize.width * 0.45,
                            height: screenSize.height * 0.06,
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
                                    borderRadius: BorderRadius.circular(
                                        screenSize.width * 0.1),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Editcontact(
                                            clinic: clinic,
                                          )),
                                );
                                setState(() {
                                  
                                });
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
