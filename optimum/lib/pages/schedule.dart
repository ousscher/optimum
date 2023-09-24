import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/services/database.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import 'package:intl/intl.dart';

class Schedule extends StatefulWidget {
  Medecin? medecin;
  Patient? patient;
  Schedule({super.key, required this.medecin, required this.patient});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  int selectedIndex = -1;
  int selectedIndex2 = -1;
  int index3 = -1;
  List<String> Morning = [ 
    '8:00 AM',
    '8:20 AM',
    '8:40 AM',
    '9:00 AM',
    '9:20 AM',
    '9:40 AM',
    '10:00 AM',
    '10:20 AM',
    '10:40 AM',
    '11:00 AM',
    '11:20 AM',
    '11:40 AM',
  ];
  List<String> Afternoon = [
    '1:00 PM',
    '1:20 PM',
    '1:40 PM',
    '2:00 PM',
    '2:20 PM',
    '2:40 PM',
    '3:00 PM',
    '3:20 PM',
    '3:40 PM',
    '4:00 PM',
    '4:20 PM',
    '4:40 PM',
    '5:00 PM',
    '5:20 PM',
    '5:40 PM',
  ];
  List<Map<String, dynamic>> appoinmentsList = [];

  void handleButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void handleButtonPressed2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Widget build(BuildContext context) {
    bool isExistAppoinmentMorning(int index){
      Map<String, dynamic> appoinment = {
        'idClient': widget.patient!.getUid(),
        'date': selectedDate,
        'hour': Morning[index],
        };
        bool existAppoinments = appoinmentsList.any(
        (element) =>
        element['date'] == appoinment['date'] &&
        element['hour'] == appoinment['hour']);
        if (!existAppoinments) {
        return false;
        } else
        return true;
    }
    bool isExistAppoinmentAfternoon(int index){
      Map<String, dynamic> appoinment = {
        'idClient': widget.patient!.getUid(),
        'date': selectedDate,
        'hour': Afternoon[index],
        };
        bool existAppoinments = appoinmentsList.any(
        (element) =>
        element['date'] == appoinment['date'] &&
        element['hour'] == appoinment['hour']);
        if (!existAppoinments) {
        return false;
        } else
        return true;
    }
    final medecinRef = FirebaseFirestore.instance
        .collection('meds')
        .doc(widget.medecin!.getUid());
    final appointmentCollection = medecinRef.collection('appointments');
    appointmentCollection.snapshots().listen((QuerySnapshot snapshot) {
      // Ici, on traite les modifications
      //ici se fera la mise à jour du front
      snapshot.docs.forEach((DocumentSnapshot doc) {
        // print("   ${doc['date']}   ${doc['hour']}");
        Map<String, dynamic> newAppoinment = {
          "date": doc['date'],
          "hour": doc['hour'],
        };
        bool existAppoinments = appoinmentsList.any((element) =>
            element['date'] == newAppoinment['date'] &&
            element['hour'] == newAppoinment['hour']);
        if (!existAppoinments) {
          setState(() {
            appoinmentsList.add(newAppoinment);
          });
        }
        // print("new our list    ");
        // appoinmentsList.forEach((element) {
        //   print(element['date']);
        //   print(element['hour']);
        // });
        // Accédez aux données du document (par exemple, doc['date'], doc['medecinId'], etc.)
      });
    });
    // -----------------------------------------------------------------
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'schedule_dark'
        : 'schedule';
    final Size screenSize = MediaQuery.of(context).size;
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
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, screenSize.height * 0.06, screenSize.width * 0.7, 0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                }, // Menu button
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color(0xFFD37777),
                ),
                backgroundColor: Theme.of(context).shadowColor,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.015,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.03),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/plus.png',
                        height: screenSize.width * 0.09,
                        width: screenSize.width * 0.09,
                      ),
                      SizedBox(
                        width: screenSize.width * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Dr. ${widget.medecin!.getName()} ${widget.medecin!.getLastName()}',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: screenSize.width * 0.06,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: Color(0xFFD37777),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.001,
                          ),
                          Text(
                            'Cardiologist',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: screenSize.width * 0.03,
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.005,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Color(0xFFD37777),
                                size: screenSize.width * 0.05,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.005,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFD37777),
                                size: screenSize.width * 0.05,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.005,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFD37777),
                                size: screenSize.width * 0.05,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.005,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFD37777),
                                size: screenSize.width * 0.05,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.005,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: screenSize.width * 0.05,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.009,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.13),
                  child: Text(
                    'SCHEDULE',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: screenSize.width * 0.13,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.035,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.03),
                  child: Text(
                    'Choose a Date & Time',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: screenSize.width * 0.08,
                      color: Color(0xFF66B3FF),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.05),
                  child: Text(
                    'Days:',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: screenSize.width * 0.07,
                      color: Color(0xFF66B3FF),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Container(
                  color: Theme.of(context).shadowColor,
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.001,
                      horizontal: screenSize.width * 0.01),
                  child: DatePicker(
                    DateTime.now(),
                    height: 100,
                    width: 80,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Color(0xFF00437A),
                    selectedTextColor: Color(0xFFD37777),
                    dateTextStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    dayTextStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    monthTextStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                    ),
                    onDateChange: (date) {
                      setState(() {
                        selectedDate = DateFormat('dd-MM-yyyy').format(date);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.05),
                  child: Text(
                    'Morning:',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: screenSize.width * 0.07,
                      color: Color(0xFF66B3FF),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                    itemCount: 12,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.02),
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.001,
                            horizontal: screenSize.width * 0.01),
                        child: (isExistAppoinmentMorning(index))? 
                        ElevatedButton(
                          onPressed: () {
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(1),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              return Theme.of(context).shadowColor;
                            }),
                          ),
                          child: Text(
                            Morning[index],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        )
                        :
                        ElevatedButton(
                          onPressed: () {
                            handleButtonPressed(index);
                            handleButtonPressed2(index3);
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(1),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color(0xFF00437A);
                              } else if (index == selectedIndex) {
                                return Color(0xFF00437A);
                              }
                              return Theme.of(context).shadowColor;
                            }),
                          ),
                          child: Text(
                            Morning[index],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: index == selectedIndex
                                  ? Color(0xFFD37777)
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.05),
                  child: Text(
                    'Afternoon:',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: screenSize.width * 0.07,
                      color: Color(0xFF66B3FF),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                    itemCount: 12,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index2) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.02),
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.001,
                            horizontal: screenSize.width * 0.01),
                        child: (isExistAppoinmentAfternoon(index2))? 
                        ElevatedButton(
                          onPressed: () {
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(1),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              return Theme.of(context).shadowColor;
                            }),
                          ),
                          child: Text(
                            Afternoon[index2],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        )
                        :
                        ElevatedButton(
                          onPressed: () {
                            handleButtonPressed2(index2);
                            handleButtonPressed(index3);
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(1),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color(0xFF00437A);
                              } else if (index2 == selectedIndex2) {
                                return Color(0xFF00437A);
                              }
                              return Theme.of(context).shadowColor;
                            }),
                          ),
                          child: Text(
                            Afternoon[index2],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: index2 == selectedIndex2
                                  ? Color(0xFFD37777)
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.035,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.3),
                  child: Container(
                    width: screenSize.width * 0.38,
                    height: screenSize.height * 0.06,
                    child: (selectedIndex != -1 || selectedIndex2 != -1)
                        ? TextButton(
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
                            onPressed: () {
                              //on recupere l'heure de debut et de fin
                              //on fait l'exemple avec 08.00

                              if (selectedIndex != -1) {
                                Map<String, dynamic> appoinment = {
                                  'idClient': widget.patient!.getUid(),
                                  'date': selectedDate,
                                  'hour': Morning[selectedIndex],
                                };
                                bool existAppoinments = appoinmentsList.any(
                                    (element) =>
                                        element['date'] == appoinment['date'] &&
                                        element['hour'] == appoinment['hour']);
                                if (!existAppoinments) {
                                  setState(() {
                                    appointmentCollection.add(appoinment);
                                    appoinmentsList.add(appoinment);
                                    selectedIndex = -1;
                                  });
                                } else
                                  print("rendez vous deja reserve");
                              } else {
                                if (selectedIndex2 != -1) {
                                  Map<String, dynamic> appoinment = {
                                    'idClient': widget.patient!.getUid(),
                                    'date': selectedDate,
                                    'hour': Afternoon[selectedIndex2],
                                  };
                                  bool existAppoinments = appoinmentsList.any(
                                      (element) =>
                                          element['date'] ==
                                              appoinment['date'] &&
                                          element['hour'] ==
                                              appoinment['hour']);
                                  if (!existAppoinments) {
                                    setState(() {
                                      appointmentCollection.add(appoinment);
                                      appoinmentsList.add(appoinment);
                                      selectedIndex2 = -1;
                                    });
                                  } else {
                                    print("rendez vous deja reserve");
                                    setState(() {
                                      selectedIndex = -1;
                                      selectedIndex2 = -1;
                                    });
                                  }
                                }
                              }
                            },
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                color: Theme.of(context).shadowColor,
                                fontFamily: 'Oswald',
                                fontSize: screenSize.width * 0.047,
                              ),
                            ),
                          )
                        : TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Color.fromARGB(255, 85, 85, 85);
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
                            onPressed: () {},
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                color: Theme.of(context).shadowColor,
                                fontFamily: 'Oswald',
                                fontSize: screenSize.width * 0.047,
                              ),
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
