import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../provider/theme_provider.dart';

class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
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
    final now = DateTime.now();
    final targetDate = DateTime(now.year, 4, 30);
    final targetTime = TimeOfDay(hour: 13, minute: 20);
    final isTargetDate = now.year < targetDate.year &&
        now.month < targetDate.month &&
        now.day < targetDate.day;
    final isTargetTime = now.hour < targetTime.hour &&
        now.minute < targetTime.minute;
    final shouldShowCancelButton = isTargetDate || isTargetTime;
    double height = shouldShowCancelButton ? 0.23 : 0.17;
    setState(() {
      additionalSurgeryCodeSections.insert(
        0,
        Container(
          height: screenSize.height * height,
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
                  child:  Image.asset(
                    'assets/images/bookings_icon.png',
                  ),

                ),
                SizedBox(width: screenSize.width * 0.055,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Thursday, April 30',
                      style: TextStyle(
                        color: Color(0xFF70A4EA),
                        fontFamily: 'Oswald',
                        fontSize: screenSize.width * 0.07,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      '1:20PM - 1:40PM',
                      style: TextStyle(
                        color: Color(0xFF70A4EA),
                        fontFamily: 'Oswald',
                        fontSize: screenSize.width * 0.045,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'With Dr.Soltani',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: screenSize.width * 0.04,
                        letterSpacing: 1.0,
                      ),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Status:',
                          style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontFamily: 'Oswald',
                            fontSize: screenSize.width * 0.04,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.04,),
                        Text(
                          'On Time',
                          style: TextStyle(
                            color: Color(0xFFD37777),
                            fontFamily: 'Poppins',
                            fontSize: screenSize.width * 0.04,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.015,),
                    shouldShowCancelButton ? Container(
                      width: screenSize.width * 0.35,
                      height: screenSize.height * 0.04,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Color(0xFFD37777);
                            },
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(screenSize.width * 0.1),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _deleteSurgerySection();
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Reservation Canceled!',
                              message:
                              'Your Booking Appointment has been canceled successfully! We hope you are sure of your decision',
                              contentType: ContentType.failure,
                            ),
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Oswald',
                            letterSpacing: 1.0,
                            fontSize: screenSize.height * 0.015,
                          ),
                        ),
                      ),
                    ) : SizedBox(),
                  ],
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
        
        additionalSurgeryCodeSections.removeAt(0);
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
                SizedBox(width: screenSize.width * 0.07,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, screenSize.height * 0.045, 0, 0),
                  child: Text(
                    'Booking History',
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
              'All Your Bookings',
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