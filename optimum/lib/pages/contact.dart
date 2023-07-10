import 'package:flutter/material.dart';
import 'package:optimum/pages/home_page.dart';


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
              padding: EdgeInsets.fromLTRB(0, screenSize.height * 0.06, screenSize.width * 0.7, 0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },// Menu button
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFFD37777),
                ),
                backgroundColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: screenSize.height * 0.28),
            Padding(
              padding: EdgeInsets.fromLTRB( 0, 0, screenSize.width * 0.1, 0),
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
            SizedBox(height: screenSize.height * 0.03,),
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
                          onPressed: (){},
                          child:Image.asset(
                            'assets/images/email_icon.png',
                            width: screenSize.width * 0.1 ,
                            height: screenSize.height * 0.1 ,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.grey.shade300;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.06,),
                      GestureDetector(
                        onTap: (){},
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
                  SizedBox(height: screenSize.height * 0.02,),
                  Row(
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.15,
                        height: screenSize.width * 0.15,
                        child: TextButton(
                          onPressed: (){},
                          child: Image.asset(
                            'assets/images/phone_icon.png',
                            width: screenSize.width * 0.07 ,
                            height: screenSize.height * 0.07 ,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.grey.shade300;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.06,),
                      GestureDetector(
                        onTap: (){},
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
                        onTap: (){},
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
                  SizedBox(height: screenSize.height * 0.02 ,),
                  Row(
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.15,
                        height: screenSize.width * 0.15,
                        child: TextButton(
                          onPressed: (){},
                          child: Image.asset(
                            'assets/images/location_icon.png',
                            width: screenSize.width * 0.07 ,
                            height: screenSize.height * 0.07 ,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.grey.shade300;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.06,),
                      GestureDetector(
                        onTap: (){},
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
                  SizedBox(height: screenSize.height * 0.02,),
                  Row(
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.15,
                        height: screenSize.width * 0.15,
                        child: TextButton(
                          onPressed: (){},
                          child: Image.asset(
                            'assets/images/facebook.png',
                            width: screenSize.width * 0.1 ,
                            height: screenSize.height * 0.1 ,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.grey.shade300;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.06,),
                      GestureDetector(
                        onTap: (){},
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
                  SizedBox(height: screenSize.height * 0.02,),
                  Row(
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.15,
                        height: screenSize.width * 0.15,
                        child: TextButton(
                          onPressed: (){},
                          child: Image.asset(
                            'assets/images/instagram.png',
                            width: screenSize.width * 0.08 ,
                            height: screenSize.height * 0.08 ,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.grey.shade300;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.06,),
                      GestureDetector(
                        onTap: (){},
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
