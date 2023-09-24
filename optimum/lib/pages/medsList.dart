import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/schedule.dart';
import 'package:optimum/provider/theme_provider.dart';
import 'package:optimum/services/database.dart';
import 'package:provider/provider.dart';

class MedsList extends StatefulWidget {
  Patient? patient;
  MedsList({super.key, required this.patient});

  @override
  State<MedsList> createState() => _MedsListState();
}

class _MedsListState extends State<MedsList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Medecin>?>.value(
      initialData: null,
      value: DatabaseService.meds,
      child: ListMedecin(
        patient: widget.patient,
      ),
    );
  }
}

class ListMedecin extends StatefulWidget {
  Patient? patient;
  ListMedecin({super.key, required this.patient});
  @override
  State<ListMedecin> createState() => _ListMedecinState();
}

class _ListMedecinState extends State<ListMedecin> {
  @override
  Widget build(BuildContext context) {
    List<Widget> medecinsWidgetList = [];
    final medecins = Provider.of<List<Medecin>?>(context);
    print(medecins);
    if (medecins != null) {
      medecins.forEach((element) {
        setState(() {
          medecinsWidgetList.add(CardMedecin(medecin: element , patient: widget.patient,));
        });
      });
    }
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
                  width: screenSize.width * 0.07,
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, screenSize.height * 0.045, 0, 0),
                  child: Text(
                    'Discover our doctors',
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
              'Our doctors',
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
                  children: medecinsWidgetList,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardMedecin extends StatelessWidget {
  Medecin? medecin;
  Patient? patient;
  CardMedecin({super.key, required this.medecin , required this.patient});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print(medecin!.getUrlPhoto());
    print(medecin!.getAttendence());
    print(medecin!.getEmail());
    return Container(
      height: screenSize.height * 0.2,
      width: screenSize.width * 0.93,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Schedule(patient: patient,medecin: medecin,),
              ));
        },
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: medecin!.getUrlPhoto() == null
                          ? AssetImage('assets/images/profil_pic.png')
                          : Image.network(medecin!.getUrlPhoto()!).image,
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.055,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${medecin!.getName()} ${medecin!.getLastName()}',
                    style: TextStyle(
                      color: Color(0xFF70A4EA),
                      fontFamily: 'Oswald',
                      fontSize: screenSize.width * 0.07,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    medecin!.getSpecialite() ?? '',
                    style: TextStyle(
                      color: Color(0xFF70A4EA),
                      fontFamily: 'Oswald',
                      fontSize: screenSize.width * 0.045,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    medecin!.getAttendence() ?? '',
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
                      SizedBox(
                        width: screenSize.width * 0.04,
                      ),
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
                  SizedBox(
                    height: screenSize.height * 0.015,
                  ),
                  // shouldShowCancelButton
                  //     ? Container(
                  //         width: screenSize.width * 0.35,
                  //         height: screenSize.height * 0.04,
                  //         child: TextButton(
                  //           style: ButtonStyle(
                  //             backgroundColor:
                  //                 MaterialStateProperty.resolveWith<Color>(
                  //               (Set<MaterialState> states) {
                  //                 return Color(0xFFD37777);
                  //               },
                  //             ),
                  //             shape: MaterialStateProperty.all<
                  //                 RoundedRectangleBorder>(
                  //               RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(
                  //                     screenSize.width * 0.1),
                  //               ),
                  //             ),
                  //           ),
                  //           onPressed: () {},
                  //           child: Text(
                  //             'Cancel',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontFamily: 'Oswald',
                  //               letterSpacing: 1.0,
                  //               fontSize: screenSize.height * 0.015,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
