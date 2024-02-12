import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/services/database.dart';
import 'package:optimum/shared/loading.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../provider/theme_provider.dart';

Future<String?> gettask(String email, String task) async {
  try {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('meds')
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      if (data.containsKey('email') && data['email'] == email) {
        return data['$task'] as String?;
      }
    }

    print('No documents found with email $email');
    return null;
  } catch (error) {
    print('Error fetching specialite: $error');
    return null;
  }
}
Future<String?> deletedr(String email) async {
  try {
    await _deleteDocuments('meds', email);
    await _deleteDocuments('listMedecins', email);
    final user = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email)
        .then((signInMethods) async {
      if (signInMethods.isNotEmpty) {
        final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: '99999999',
        );
        return userCredential.user;
      } else {
        return null;
      }
    });

    if (user != null) {
      await user.delete();
      print('User with email $email authentication deleted successfully');
    }

    return null;
  } catch (error) {
    print('Error deleting documents and user: $error');
    return null;
  }
}

Future<void> _deleteDocuments(String collectionName, String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(collectionName)
      .where('email', isEqualTo: email)
      .get();

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    await doc.reference.delete();
    print('Document from $collectionName with email $email deleted successfully');
  }
}


class Removedr extends StatefulWidget {
  const Removedr({super.key});

  @override
  State<Removedr> createState() => _RemovedrState();
}

class _RemovedrState extends State<Removedr> {
  List<String> doctorMails = [];
  List<Widget> cardMedecins = [];
  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    Future<List<String>> fetchData(Size screenSize) async {
      final Size screenSize = MediaQuery.of(context).size;
      final firestore = FirebaseFirestore.instance;
      List<String> mails = [];
      try {
        final collectionReference = firestore.collection('listMedecins');
        final querySnapshot = await collectionReference.get();
        mails =
            querySnapshot.docs.map((doc) => doc['email'] as String).toList();
        setState(() {
          doctorMails = mails;
        });
      } catch (e) {
        print('Error fetching data: $e');
      }
      if (!mounted) return [];
      setState(() {

        cardMedecins = mails
            .map(
              (e) => Container(
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
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: screenSize.width * 0.2,
                          height: screenSize.width * 0.2,
                          child: ClipOval(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: screenSize.width * 0.1,
                              child: FutureBuilder<String?>(
                                future: gettask(e,'profilePhotoURL'),
                                builder: (context, snapshot) {
                                  final imagePath = snapshot.data ?? "assets/images/profil_pic.png";
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xFFD37777),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: imagePath.startsWith('http')
                                          ? Image.network(
                                        imagePath,
                                        fit: BoxFit.cover,
                                        width: screenSize.width * 0.2,
                                        height: screenSize.width * 0.2,
                                      )
                                          : Image.asset(
                                        imagePath,
                                        fit: BoxFit.cover,
                                        width: screenSize.width * 0.2,
                                        height: screenSize.width * 0.2,
                                      ),
                                    ),
                                  );

                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.045,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FutureBuilder<String?>(
                              future: gettask(e,'lastname'),
                              builder: (context, snapshot) => Text(
                                snapshot.data ?? 'Doctor',
                                style: TextStyle(
                                  color: Color(0xFF70A4EA),
                                  fontSize: screenSize.width * 0.06,
                                  fontFamily: 'Oswald',
                                  //letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            FutureBuilder<String?>(
                              future: gettask(e,'specialite'),
                              builder: (context, snapshot) => Text(
                              snapshot.data ?? 'Doctor',
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontFamily: 'Poppins',
                                fontSize: screenSize.width * 0.04,
                                letterSpacing: 1.0,
                              ),
                              ),
                            ),

                            Row(
                              children: <Widget>[
                                Icon(
                                    Icons.star,
                                    color: const Color(0xFFD37777),
                                    size: screenSize.width * 0.03,
                                  ),
                                SizedBox(
                                  width: screenSize.width * 0.005,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFD37777),
                                  size: screenSize.width * 0.03,
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.005,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFD37777),
                                  size: screenSize.width * 0.03,
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.005,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFD37777),
                                  size: screenSize.width * 0.03,
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.005,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey.shade300,
                                  size: screenSize.width * 0.03,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenSize.width * 0.07,
                        ),
                        GestureDetector(
                          onTap: () {
                            deletedr(e);
                            DatabaseService.deleteDocumentByFieldValue(e);
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
              ),
            )
            .toList();
      });

      return mails;
    }

    final screenSize = MediaQuery.of(context).size;
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'bookings_dark'
        : 'bookings';
    return FutureBuilder<List<String>>(
      future: fetchData(screenSize),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Pendant le chargement
          return Loading(); // Ou tout autre indicateur de chargement
        } else if (snapshot.hasError)
          return Text("erreur ! ${snapshot.error}");
        else
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
                      SizedBox(
                        width: screenSize.width * 0.075,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, screenSize.height * 0.045, 0, 0),
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
                    'List of doctors',
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
                        children: cardMedecins,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
