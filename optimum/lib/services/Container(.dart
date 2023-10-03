// Container(
//       height: screenSize.height * 0.3,
//       width: screenSize.width * 0.93 ,
//       child: Card(
//         color: Theme.of(context).shadowColor,
//         elevation: 1.0,
//         shape:
//         RoundedRectangleBorder(
//           borderRadius:
//           BorderRadius.circular( screenSize.width * 0.1 ),
//           side: BorderSide(
//             color: Color(0xFF70A4EA),
//             width: 2.0,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: screenSize.width * 0.2,
//               height: screenSize.width * 0.2,
//               child:  Image.asset(
//                 'assets/images/bookings_icon.png',
//               ),

//             ),
//             SizedBox(width: screenSize.width * 0.055,),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   '${widget.date}',
//                   style: TextStyle(
//                     color: Color(0xFF70A4EA),
//                     fontFamily: 'Oswald',
//                     fontSize: screenSize.width * 0.07,
//                     letterSpacing: 1.0,
//                   ),
//                 ),
//                 Text(
//                   '${widget.date}',
//                   style: TextStyle(
//                     color: Color(0xFF70A4EA),
//                     fontFamily: 'Oswald',
//                     fontSize: screenSize.width * 0.045,
//                     letterSpacing: 1.0,
//                   ),
//                 ),
//                 Text(
//                   'With Dr. ${widget.date}',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontFamily: 'Poppins',
//                     fontSize: screenSize.width * 0.04,
//                     letterSpacing: 1.0,
//                   ),
//                 ),

//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Status:',
//                       style: TextStyle(
//                         color: Color(0xFFD9D9D9),
//                         fontFamily: 'Oswald',
//                         fontSize: screenSize.width * 0.04,
//                         letterSpacing: 1.0,
//                       ),
//                     ),
//                     SizedBox(width: screenSize.width * 0.04,),
//                     Text(
//                       'On Time',
//                       style: TextStyle(
//                         color: Color(0xFFD37777),
//                         fontFamily: 'Poppins',
//                         fontSize: screenSize.width * 0.04,
//                         letterSpacing: 1.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenSize.height * 0.015,),
//                 Container(
//                   width: screenSize.width * 0.35,
//                   height: screenSize.height * 0.04,
//                   child: TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                             (Set<MaterialState> states) {
//                           return Color(0xFFD37777);
//                         },
//                       ),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius:
//                           BorderRadius.circular(screenSize.width * 0.1),
//                         ),
//                       ),
//                     ),
//                     onPressed: () {
//                      // _deleteSurgerySection();
//                       final snackBar = SnackBar(
//                         elevation: 0,
//                         behavior: SnackBarBehavior.floating,
//                         backgroundColor: Colors.transparent,
//                         content: AwesomeSnackbarContent(
//                           title: 'Reservation Canceled!',
//                           message:
//                           'Your Booking Appointment has been canceled successfully! We hope you are sure of your decision',
//                           contentType: ContentType.failure,
//                         ),
//                       );
//                       ScaffoldMessenger.of(context)
//                         ..hideCurrentSnackBar()..showSnackBar(snackBar);
//                     },
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Oswald',
//                         letterSpacing: 1.0,
//                         fontSize: screenSize.height * 0.015,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );








//     import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/theme_provider.dart';
// import '../services/database.dart';

// class BookingsListt extends StatefulWidget {
//   const BookingsListt({super.key});

//   @override
//   State<BookingsListt> createState() => _BookingsListState();
// }

// class _BookingsListState extends State<BookingsListt> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<Map<String, dynamic>?>?>.value(
//       initialData: null,
//       value: DatabaseService.appoinmentsPatient,
//       child: Bookinghistory(),
//     );
//   }
// }

// class Bookinghistory extends StatefulWidget {
//   const Bookinghistory({super.key});

//   @override
//   State<Bookinghistory> createState() => _BookinghistoryState();
// }

// class _BookinghistoryState extends State<Bookinghistory> {
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> appoinmentsWidgetList = [];
//     final appoinmentsList = Provider.of<List<Map<String, dynamic>?>?>(context);
//     final screenSize = MediaQuery.of(context).size;
//     final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
//         ? 'bookings_dark'
//         : 'bookings';
//     print("build function");
//     if (appoinmentsList != null) {
//       print ("------------");
//       appoinmentsList.forEach((element) {
//         print(element!['date']);
//         print(element['hour']);
//         setState(() {
//           appoinmentsWidgetList.add(appoinmetCard(
//             list: element,
//             // patient: widget.patient,
//           ));
//         });
//       });
//     }
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/' + '$img' + '.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(
//                       screenSize.width * 0.06, screenSize.height * 0.045, 0, 0),
//                   child: FloatingActionButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     }, // Menu button
//                     child: Icon(
//                       Icons.arrow_back_ios_new,
//                       color: Color(0xFFD37777),
//                     ),
//                     backgroundColor: Theme.of(context).shadowColor,
//                   ),
//                 ),
//                 SizedBox(
//                   width: screenSize.width * 0.07,
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.fromLTRB(0, screenSize.height * 0.045, 0, 0),
//                   child: Text(
//                     'Booking History',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: screenSize.width * 0.06,
//                       fontFamily: 'Oswald',
//                       letterSpacing: 2.0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: screenSize.height * 0.035,
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(
//                   screenSize.width * 0.05, 0, screenSize.width * 0.05, 0),
//               child: Divider(
//                 height: screenSize.height * 0.01,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(
//               height: screenSize.height * 0.007,
//             ),
//             Text(
//               'All Your Bookings',
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontSize: screenSize.height * 0.03,
//                 letterSpacing: 1.0,
//                 color: Color(0xFFD37777),
//               ),
//             ),
//             SizedBox(
//               height: screenSize.height * 0.007,
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(
//                   screenSize.width * 0.05, 0, screenSize.width * 0.05, 0),
//               child: Divider(
//                 height: screenSize.height * 0.01,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(height: screenSize.height * 0.02),
//             Container(
//               height: screenSize.height * 0.68,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: appoinmentsWidgetList,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class appoinmetCard extends StatefulWidget {
//   Map<String, dynamic>? list;
//   appoinmetCard({super.key, required this.list});

//   @override
//   State<appoinmetCard> createState() => _appoinmetCardState();
// }

// class _appoinmetCardState extends State<appoinmetCard> {
//   Future<String?> getUserName(String uid) async {
//     try {
//       // Accédez à la collection "users" et utilisez la méthode "where" pour filtrer par UID.
//       DocumentSnapshot documentSnapshot =
//           await FirebaseFirestore.instance.collection('users').doc(uid).get();

//       // Vérifiez si des documents correspondant à l'UID ont été trouvés.
//       if (documentSnapshot.exists) {
//         // Accédez au champ "nom" du premier document (s'il y en a plusieurs, prenez-en un).
//         Map<String, dynamic> data =
//             documentSnapshot.data() as Map<String, dynamic>;
//         String? userName = data['name'] as String?;
//         userName = userName! + " " + data['lastname'];
//         print(userName);
//         return userName;
//       } else {
//         // L'utilisateur avec cet UID n'a pas été trouvé.
//         return null;
//       }
//     } catch (e) {
//       // Gérez les erreurs ici.
//       print("Erreur lors de la récupération du nom de l'utilisateur : $e");
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return FutureBuilder<String?>(
//       future: getUserName(widget.list!['idClient']),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator(); // Affichez un indicateur de chargement en attendant.
//         } else if (snapshot.hasError) {
//           return Text('Erreur : ${snapshot.error}');
//         } else {
//           String? userName = snapshot.data;
//           if (userName != null) {
//             return Container(
//               height: screenSize.height * 0.14,
//               width: screenSize.width * 0.93,
//               child: Card(
//                 color: Theme.of(context).shadowColor,
//                 elevation: 1.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(screenSize.width * 0.1),
//                   side: BorderSide(
//                     color: Color(0xFF70A4EA),
//                     width: 2.0,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       width: screenSize.width * 0.2,
//                       height: screenSize.width * 0.2,
//                       child: TextButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.resolveWith<Color>(
//                             (Set<MaterialState> states) {
//                               return Colors.white;
//                             },
//                           ),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   screenSize.width * 0.15),
//                               side: BorderSide(
//                                 width: 1.0,
//                                 color: Color(0xFFD37777),
//                               ),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           //Navigator.push(
//                           //context,
//                           //MaterialPageRoute(builder: (context) => Profile()),
//                           //);
//                         },
//                         child: Image.asset(
//                           'assets/images/profil_pic.png',
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: screenSize.width * 0.035,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           userName,
//                           style: TextStyle(
//                             color: Color(0xFF70A4EA),
//                             fontFamily: 'Oswald',
//                             fontSize: screenSize.width * 0.06,
//                             letterSpacing: 1.0,
//                           ),
//                         ),
//                         Text(
//                           '${widget.list!['date']} at ${widget.list!['hour']}',
//                           style: TextStyle(
//                             color: Color(0xFFD9D9D9),
//                             fontFamily: 'Poppins',
//                             fontSize: screenSize.width * 0.04,
//                             letterSpacing: 1.0,
//                           ),
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               'Status',
//                               style: TextStyle(
//                                 color: Color(0xFFD37777),
//                                 fontFamily: 'Oswald',
//                                 fontSize: screenSize.width * 0.045,
//                                 letterSpacing: 1.0,
//                               ),
//                             ),
//                             SizedBox(
//                               width: screenSize.width * 0.04,
//                             ),
//                             Container(
//                               width: screenSize.width * 0.4,
//                               height: screenSize.height * 0.04,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Color(0xFFD9D9D9)),
//                                 borderRadius: BorderRadius.circular(40.0),
//                                 color: Colors.grey.shade50,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(6.0),
//                                 child: MyDropdownPage(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Text('L\'utilisateur n\'a pas été trouvé.');
//           }
//         }
//       },
//     );
//   }
// }

// class MyDropdownPage extends StatefulWidget {
//   MyDropdownPage({super.key});
//   @override
//   _MyDropdownPageState createState() => _MyDropdownPageState();
// }

// class _MyDropdownPageState extends State<MyDropdownPage> {
//   String? _dropdownValue;
//   static const list1 = [
//     DropdownMenuItem(child: Text("On Time"), value: "On Time"),
//     DropdownMenuItem(child: Text("Canceled"), value: "Canceled"),
//     DropdownMenuItem(child: Text("Done"), value: "Done"),
//     DropdownMenuItem(child: Text("Next"), value: "Next"),
//     DropdownMenuItem(child: Text("Waiting for you"), value: "Waiting for you"),
//     DropdownMenuItem(child: Text("Postponed"), value: "Postponed"),
//   ];

//   void dropdownCallback(String? selectedValue) {
//     if (selectedValue is String) {
//       setState(() {
//         _dropdownValue = selectedValue;
//       });

//       // Print the selected value
//       print("Selected value: $_dropdownValue");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
//           child: DropdownButton(
//             items: list1,
//             value: _dropdownValue,
//             onChanged: dropdownCallback,
//             isExpanded: true,
//             borderRadius: BorderRadius.circular(20.0),
//             iconEnabledColor: Color(0xFFD37777),
//             iconSize: 20.0,
//             icon: Icon(
//               Icons.arrow_drop_down_circle_outlined,
//               color: Color(0xFFD37777),
//             ),
//             hint: Text('Status'),
//           ),
//         ),
//       ),
//     );
//   }
// }
