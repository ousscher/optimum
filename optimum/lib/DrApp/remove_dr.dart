import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:optimum/DrApp/Dr_profile.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../provider/theme_provider.dart';

class Removedr extends StatefulWidget {
  const Removedr({super.key});

  @override
  State<Removedr> createState() => _RemovedrState();
}

class _RemovedrState extends State<Removedr> {
  List<Widget> additionalSurgeryCodeSections = [];
  @override
  void initState() {
    super.initState();
    // Start the timer to add a new surgery section every 10 seconds
    Timer.periodic(Duration(seconds: 10), (timer) {
      addSurgerySection();
    });
  }
  void addSurgerySection() {
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      additionalSurgeryCodeSections.add(
        Container(
          height: screenSize.height * 0.14,
          width: screenSize.width * 0.93 ,
          child: Card(
            color: Theme.of(context).shadowColor,
            elevation: 1.0,
            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular( screenSize.width * 0.1 ),
              side: BorderSide(
                color: Color(0xFF70A4EA),
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenSize.width * 0.2,
                  height: screenSize.width * 0.2,
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
                            width: 1.0,
                            color: Color(0xFFD37777),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DrProfile()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/profil_pic.png',
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width * 0.045,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Dr.Soltani Amine',
                      style: TextStyle(
                        color: Color(0xFF70A4EA),
                        fontFamily: 'Oswald',
                        fontSize: screenSize.width * 0.06,
                        letterSpacing: 1.0,
                      ),
                    ),

                    Text(
                      'Cardiologist',
                      style: TextStyle(
                        color: Color(0xFFD9D9D9),
                        fontFamily: 'Poppins',
                        fontSize: screenSize.width * 0.04,
                        letterSpacing: 1.0,
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Color(0xFFD37777),
                          size: screenSize.width * 0.03,
                        ),
                        SizedBox(width: screenSize.width * 0.005,),
                        Icon(
                          Icons.star,
                          color: Color(0xFFD37777),
                          size: screenSize.width * 0.03,
                        ),
                        SizedBox(width: screenSize.width * 0.005,),
                        Icon(
                          Icons.star,
                          color: Color(0xFFD37777),
                          size: screenSize.width * 0.03,
                        ),
                        SizedBox(width: screenSize.width * 0.005,),
                        Icon(
                          Icons.star,
                          color: Color(0xFFD37777),
                          size: screenSize.width * 0.03,
                        ),
                        SizedBox(width: screenSize.width * 0.005,),
                        Icon(
                          Icons.star,
                          color: Colors.grey.shade300,
                          size: screenSize.width * 0.03,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: screenSize.width * 0.07,),
                GestureDetector(
                  onTap: (){
                    _deleteSurgerySection();
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Doctor Removed!',
                        message:
                        'This Doctor has been Removed from the list of doctors successfully! We hope you are sure of your decision',
                        contentType: ContentType.failure,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  child: Icon(
                    Icons.close,
                    color: Color(0xFFD37777),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
  void _deleteSurgerySection() {
    setState(() {
      // Use the removeLast() method to remove the last card from the list
      if (additionalSurgeryCodeSections.isNotEmpty) {
        additionalSurgeryCodeSections.removeLast();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'bookings_dark'
        : 'bookings';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/' + '$img' + '.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(screenSize.width * 0.06,
                      screenSize.height * 0.045, 0, 0),
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
                SizedBox(width: screenSize.width * 0.075,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, screenSize.height * 0.045, 0, 0),
                  child: Text(
                    'Remove Doctors',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.width * 0.06,
                      fontFamily: 'Oswald',
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.035,),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  screenSize.width * 0.05, 0, screenSize.width * 0.05, 0),
              child: Divider(
                height: screenSize.height * 0.01,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.007,
            ),
            Text(
              'List of the doctors',
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
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Container(
              height: screenSize.height * 0.68,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: additionalSurgeryCodeSections,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
