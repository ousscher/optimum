import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:optimum/provider/theme_provider.dart';
import 'package:optimum/services/database.dart';
import 'package:provider/provider.dart';

class BookingsList extends StatefulWidget {
  const BookingsList({super.key});

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Map<String, dynamic>?>?>.value(
      initialData: null,
      value: DatabaseService.appoinments,
      child: AppoinmentList(),
    );
  }
}

class AppoinmentList extends StatefulWidget {
  const AppoinmentList({super.key});

  @override
  State<AppoinmentList> createState() => _AppoinmentListState();
}

class _AppoinmentListState extends State<AppoinmentList> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'bookings_dark'
        : 'bookings';
    List<Widget> appoinmentsWidgetList = [];
    final appoinmentsList = Provider.of<List<Map<String, dynamic>?>?>(context);

    if (appoinmentsList != null) {
      appoinmentsList.forEach((element) {
        print(element!['date']);
        print(element['hour']);
        setState(() {
          appoinmentsWidgetList.add(AppoinmentCard(
            list: element,
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
                  padding: EdgeInsets.fromLTRB(
                      screenSize.width * 0.06, screenSize.height * 0.045, 0, 0),
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
                SizedBox(
                  width: screenSize.width * 0.175,
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, screenSize.height * 0.045, 0, 0),
                  child: Text(
                    'Bookings',
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
            SizedBox(
              height: screenSize.height * 0.035,
            ),
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
              'Today\'s Bookings',
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
                  children: appoinmentsWidgetList,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppoinmentCard extends StatefulWidget {
  Map<String, dynamic>? list;
  AppoinmentCard({super.key, required this.list});

  @override
  State<AppoinmentCard> createState() => _AppoinmentCardState();
}

class _AppoinmentCardState extends State<AppoinmentCard> {
  @override
  Future<String?> getUserName(String uid) async {
    try {
      // Accédez à la collection "users" et utilisez la méthode "where" pour filtrer par UID.
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Vérifiez si des documents correspondant à l'UID ont été trouvés.
      if (documentSnapshot.exists) {
        // Accédez au champ "nom" du premier document (s'il y en a plusieurs, prenez-en un).
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String? userName = data['name'] as String?;
        userName = userName! + " " + data['lastname'];
        print(userName);
        return userName;
      } else {
        // l'utilisateur qui a fait la reservation
        return null;
      }
    } catch (e) {
      // Gérez les erreurs ici.
      print("Erreur lors de la récupération du nom de l'utilisateur : $e");
      return null;
    }
  }

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'bookings_dark'
        : 'bookings';
    print(widget.list!['idClient']);
    return FutureBuilder<String?>(
      future: getUserName(widget.list!['idClient']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Affichez un indicateur de chargement en attendant.
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        } else {
          String? userName = snapshot.data;
          if (userName != null) {
            return Container(
              height: screenSize.height * 0.14,
              width: screenSize.width * 0.93,
              child: Card(
                color: Theme.of(context).shadowColor,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenSize.width * 0.1),
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
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.white;
                            },
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  screenSize.width * 0.15),
                              side: BorderSide(
                                width: 1.0,
                                color: Color(0xFFD37777),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          //Navigator.push(
                          //context,
                          //MaterialPageRoute(builder: (context) => Profile()),
                          //);
                        },
                        child: Image.asset(
                          'assets/images/profil_pic.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.035,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          userName,
                          style: TextStyle(
                            color: Color(0xFF70A4EA),
                            fontFamily: 'Oswald',
                            fontSize: screenSize.width * 0.06,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          '${widget.list!['date']} at ${widget.list!['hour']}',
                          style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontFamily: 'Poppins',
                            fontSize: screenSize.width * 0.04,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Color(0xFFD37777),
                                fontFamily: 'Oswald',
                                fontSize: screenSize.width * 0.045,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.04,
                            ),
                            Container(
                              width: screenSize.width * 0.4,
                              height: screenSize.height * 0.04,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.grey.shade50,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: MyDropdownPage(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            String? userName = snapshot.data;
            return Container(
              height: screenSize.height * 0.14,
              width: screenSize.width * 0.93,
              child: Card(
                color: Theme.of(context).shadowColor,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenSize.width * 0.1),
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
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.white;
                            },
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  screenSize.width * 0.15),
                              side: BorderSide(
                                width: 1.0,
                                color: Color(0xFFD37777),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          //Navigator.push(
                          //context,
                          //MaterialPageRoute(builder: (context) => Profile()),
                          //);
                        },
                        child: Image.asset(
                          'assets/images/profil_pic.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.035,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          "reservation has been done by you",
                          maxLines: 1,
                          style: TextStyle(
                            color: Color(0xFF70A4EA),
                            fontFamily: 'Oswald',
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          '${widget.list!['date']} at ${widget.list!['hour']}',
                          style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontFamily: 'Poppins',
                            fontSize: screenSize.width * 0.04,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Color(0xFFD37777),
                                fontFamily: 'Oswald',
                                fontSize: screenSize.width * 0.045,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.04,
                            ),
                            Container(
                              width: screenSize.width * 0.4,
                              height: screenSize.height * 0.04,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.grey.shade50,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: MyDropdownPage(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}

class MyDropdownPage extends StatefulWidget {
  MyDropdownPage({super.key});
  @override
  _MyDropdownPageState createState() => _MyDropdownPageState();
}

class _MyDropdownPageState extends State<MyDropdownPage> {
  String? _dropdownValue;
  static const list1 = [
    DropdownMenuItem(child: Text("On Time"), value: "On Time"),
    DropdownMenuItem(child: Text("Canceled"), value: "Canceled"),
    DropdownMenuItem(child: Text("Done"), value: "Done"),
    DropdownMenuItem(child: Text("Next"), value: "Next"),
    DropdownMenuItem(child: Text("Waiting for you"), value: "Waiting for you"),
    DropdownMenuItem(child: Text("Postponed"), value: "Postponed"),
  ];

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });

      // Print the selected value
      print("Selected value: $_dropdownValue");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
          child: DropdownButton(
            items: list1,
            value: _dropdownValue,
            onChanged: dropdownCallback,
            isExpanded: true,
            borderRadius: BorderRadius.circular(20.0),
            iconEnabledColor: Color(0xFFD37777),
            iconSize: 20.0,
            icon: Icon(
              Icons.arrow_drop_down_circle_outlined,
              color: Color(0xFFD37777),
            ),
            hint: Text('Status'),
          ),
        ),
      ),
    );
  }
}
