import 'package:flutter/material.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/contact.png'),
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
                backgroundColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: screenSize.height * 0.28),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, screenSize.width * 0.1, 0),
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
              height: screenSize.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.09, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.15,
                        height: screenSize.width * 0.15,
                        child: TextButton(
                          onPressed: () async {
                            String? encodeQueryParameters(Map<String, String> params) {
                              return params.entries
                                  .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&');
                            }
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: 'lm_soltani@esi.dz',
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Patient Question',
                              }),
                            );
                            try{
                              await launchUrl(emailUri);
                            }catch(e){
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
                          String? encodeQueryParameters(Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }
                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: 'lm_soltani@esi.dz',
                            query: encodeQueryParameters(<String, String>{
                              'subject': 'Patient Question',
                            }),
                          );
                          try{
                            await launchUrl(emailUri);
                          }catch(e){
                            print(e.toString());
                          }
                        },
                        child: Text(
                          'lm_soltani@esi.dz',
                          style: TextStyle(
                            color: Colors.black,
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
                              path: '021444412',
                            );
                            try{
                              await launchUrl(phoneUri);
                            }catch(e){
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
                            path: '021444412',
                          );
                          try{
                            await launchUrl(phoneUri);
                          }catch(e){
                            print(e.toString());
                          }
                        },
                        child: Text(
                          'O21 44 44 12 ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.height * 0.025,
                            fontFamily: 'Oswald',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {

                          final Uri phoneUri = Uri(
                            scheme: 'tel',
                            path: '0734665501',
                          );
                          try{
                            await launchUrl(phoneUri);
                          }catch(e){
                            print(e.toString());
                          }
                        },
                        child: Text(
                          '/ O7 34 66 55 01',
                          style: TextStyle(
                            color: Colors.black,
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
                              path: 'maps/place/Grande+Poste+d\'Alger/@36.7729353,3.0590101,19z/data=!4m6!3m5!1s0x128fb2f7afffd155:0x1f9fda77ca70e32f!8m2!3d36.7729353!4d3.0594429!16s%2Fg%2F1jgm1x08z?entry=ttu',
                            );
                            try{
                              await launchUrl(mapsUri);
                            }catch(e){
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
                            path: 'maps/place/Grande+Poste+d\'Alger/@36.7729353,3.0590101,19z/data=!4m6!3m5!1s0x128fb2f7afffd155:0x1f9fda77ca70e32f!8m2!3d36.7729353!4d3.0594429!16s%2Fg%2F1jgm1x08z?entry=ttu',
                          );
                          try{
                            await launchUrl(mapsUri);
                          }catch(e){
                            print(e.toString());
                          }
                        },
                        child: Text(
                          '12 Rue Ben Azzouz, Algiers',
                          style: TextStyle(
                            color: Colors.black,
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
                            try{
                              await launchUrl(facebookUri);
                            }catch(e){
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
                          try{
                            await launchUrl(facebookUri);
                          }catch(e){
                            print(e.toString());
                          }
                        },
                        child: Text(
                          'Cabinet Dr Soltani Amine',
                          style: TextStyle(
                            color: Colors.black,
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
                              path: 'amine__soltani',
                            );
                            try{
                              await launchUrl(instagramUri);
                            }catch(e){
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
                            path: 'amine__soltani',
                          );
                          try{
                            await launchUrl(instagramUri);
                          }catch(e){
                            print(e.toString());
                          }
                        },
                        child: Text(
                          'Dr.Soltani.Amine',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.height * 0.025,
                            fontFamily: 'Oswald',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
