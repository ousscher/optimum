import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 36.0, 270, 0),
              child: FloatingActionButton(
                onPressed: () {},          //Menu button
                child: Icon(
                  Icons.menu,
                  color: Color(0xFFD37777),
                ),
                backgroundColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 200.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70.0, 40.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hi, Amine!',
                    style: TextStyle(
                      color: Color(0xFF66B3FF),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontFamily: 'Oswald',
                    ),
                  ),

              SizedBox(height: 10.0,),
              Text(
                'We hope that you are well!',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 15.0,
                  letterSpacing: 1.0,
                  fontFamily: 'poppins',
                ),
              ),
              SizedBox(height: 2.0,),
              Text(
                'So, how can we help you?',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 15.0,
                  letterSpacing: 1.0,
                  fontFamily: 'poppins',
                ),
              ),
                ],
              ),
            ),
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(
                                  color: Color(0xFFD37777),
                                  //style: BorderStyle.solid,
                                ), // Add the desired border color
                              ),
                            ),
                          ),
                          onPressed: (){},
                          child: Icon(
                            Icons.schedule,
                            color: Color(0xFFD37777),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      Text(
                        'Book appointment',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(
                                  color: Color(0xFFD37777),
                                  //style: BorderStyle.solid,
                                ), // Add the desired border color
                              ),
                            ),
                          ),
                          onPressed: (){},
                          child: Icon(
                            Icons.phone,
                            color: Color(0xFFD37777),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(
                                  color: Color(0xFFD37777),
                                  //style: BorderStyle.solid,
                                ), // Add the desired border color
                              ),
                            ),
                          ),
                          onPressed: (){},
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFFD37777),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 80.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(
                                  color: Color(0xFFD37777),
                                  //style: BorderStyle.solid,
                                ), // Add the desired border color
                              ),
                            ),
                          ),
                          onPressed: (){},
                          child: Icon(
                            Icons.medical_services,
                            color: Color(0xFFD37777),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        'About Dr',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                          fontFamily: 'poppins',
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
