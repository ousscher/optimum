import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/users.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../models/user.dart';
import '../provider/theme_provider.dart';
import '../services/database.dart';


class AppointListt extends StatefulWidget {

  AppointListt({super.key});

  @override
  State<AppointListt> createState() => _AppointListState();
}

class _AppointListState extends State<AppointListt> {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Map<String, dynamic>?>?>.value(
      initialData: null,
      value: DatabaseService().appoinmentsPatient,
      child: Bookinghistory(list: const {}),
    );
  }
}
class Bookinghistory extends StatefulWidget {
  Map<String, dynamic>? list;
  Bookinghistory({Key? key, required this.list}): super(key: key);

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  List<Widget> additionalSurgeryCodeSections = [];

  void _deleteSurgerySection() {
    setState(() {
      additionalSurgeryCodeSections.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appoinmentsList = Provider.of<List<Map<String, dynamic>?>?>(context);
    final screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'bookings_dark'
        : 'bookings';
    if (appoinmentsList != null) {
      appoinmentsList.forEach((element) {
        print(element!['date']);
        print(element['hour']);
        setState(() {
          additionalSurgeryCodeSections.add(HistoryCard(
            list: element,
            deleteSurgerySection: _deleteSurgerySection,
            // patient: widget.patient,
          ));
        });
      });
    } else
      print("tu es dans le null");
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
                child: additionalSurgeryCodeSections.isEmpty ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      SizedBox(height: screenSize.height * 0.26,),
                      Text(
                        'NO Bookings Yet!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: screenSize.height * 0.017,
                          letterSpacing: 1.0,
                          color: Color(0xFFBEBEBE),
                        ),
                      ),
                    ]
                ) : Column(
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


class HistoryCard extends StatefulWidget {
  Map<String, dynamic>? list;
  final VoidCallback deleteSurgerySection;
  HistoryCard({Key? key, required this.list, required this.deleteSurgerySection}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final now = DateTime.now();
    // Parsing date string
    final dateParts = '${widget.list!['date']}'.split('-');
    final targetDate = DateTime(int.parse(dateParts[2]), int.parse(dateParts[1]), int.parse(dateParts[0]));
// Parsing time string
    final timeParts = '${widget.list!['hour']}'.split(' ');
    final hourMinuteParts = timeParts[0].split(':');
    int hour = int.parse(hourMinuteParts[0]);
    int minute = int.parse(hourMinuteParts[1]);
    if (timeParts[1] == 'PM') {
      hour += 12;
    }
    final targetTime = TimeOfDay(hour: hour, minute: minute);
// Creating targetDateTime
    final targetDateTime = DateTime(targetDate.year, targetDate.month, targetDate.day, targetTime.hour, targetTime.minute);
// Calculating other conditions
    final isTargetDateTime = now.compareTo(targetDateTime) <= 0;
    final shouldShowCancelButton = isTargetDateTime;
    double height = shouldShowCancelButton ? 0.23 : 0.17;

    void _onCancelPressed(String uid, String did) {
      String date = widget.list!['date'];
      String time = widget.list!['hour'];
      String compositeKey = '$date';
      String compositeKey2 = '$time';
      FirebaseFirestore.instance.collection('users')
          .doc(uid)
          .collection('appointments')
          .where('date', isEqualTo: compositeKey)
          .where('hour', isEqualTo: compositeKey2)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.first.reference.delete().then((_) {
            widget.deleteSurgerySection();
            setState(() {});
          }).catchError((error) {
            print('Error deleting appointment: $error');
          });
        } else {
          print('No matching appointment found.');
        }
      }).catchError((error) {
        print('Error querying appointments: $error');
      });
      FirebaseFirestore.instance.collection('meds')
          .doc(did)
          .collection('appointments')
          .where('date', isEqualTo: compositeKey)
          .where('hour', isEqualTo: compositeKey2)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.first.reference.delete().then((_) {
            widget.deleteSurgerySection();
            setState(() {});
          }).catchError((error) {
            print('Error deleting appointment: $error');
          });
        } else {
          print('No matching appointment found.');
        }
      }).catchError((error) {
        print('Error querying appointments: $error');
      });
    }
    return Container(
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
                  '${widget.list!['date']}',
                  style: TextStyle(
                    color: Color(0xFF70A4EA),
                    fontFamily: 'Oswald',
                    fontSize: screenSize.width * 0.07,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  '${widget.list!['hour']}',
                  style: TextStyle(
                    color: Color(0xFF70A4EA),
                    fontFamily: 'Oswald',
                    fontSize: screenSize.width * 0.045,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'With Dr.${widget.list!['drname']}',
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
                      '${widget.list!['status']}',
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
                      _onCancelPressed(widget.list!['idClient'],widget.list!['idDoctor']);
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
    );
  }
}