import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:optimum/DrApp/bookingsList.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../provider/theme_provider.dart';
import '../services/database.dart';


class BookingsListt extends StatefulWidget {
  const BookingsListt({super.key});

  @override
  State<BookingsListt> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsListt> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Map<String, dynamic>?>?>.value(
      initialData: null,
      value: DatabaseService.appoinmentsPatient,
      child: Bookinghistory(),
    );
  }
}


class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  List<Widget> appoinmentsWidgets = [];
  @override


  /*void _deleteSurgerySection() {
    setState(() {
      // Use the removeLast() method to remove the last card from the list
      if (appoinmentsWidgets.isNotEmpty) {

        appoinmentsWidgets.removeAt(0);
      }
    });
  }*/
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>?>? appoinmentsList = Provider.of<List<Map<String, dynamic>?>?>(context);
    final screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'bookings_dark'
        : 'bookings';
    if (appoinmentsList != null) {
      appoinmentsList.forEach((element) {
        print(element!['date']);
        print(element['hour']);
        setState(() {
          appoinmentsWidgets.add(appoinmetCard(
            date: element!['date']
            // patient: widget.patient,
          ));
        });
      });
    }
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
                  children: appoinmentsWidgets,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class appoinmetCard extends StatefulWidget {
  String date;
  appoinmetCard({super.key , required this.date});

  @override
  State<appoinmetCard> createState() => _appoinmetCardState();
}

class _appoinmetCardState extends State<appoinmetCard> {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.3,
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
                  '${widget.date}',
                  style: TextStyle(
                    color: Color(0xFF70A4EA),
                    fontFamily: 'Oswald',
                    fontSize: screenSize.width * 0.07,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  '${widget.date}',
                  style: TextStyle(
                    color: Color(0xFF70A4EA),
                    fontFamily: 'Oswald',
                    fontSize: screenSize.width * 0.045,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'With Dr. ${widget.date}',
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
                Container(
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
                     // _deleteSurgerySection();
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
