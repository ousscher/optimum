import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Wrapper.dart';

class Safety extends StatefulWidget {
  const Safety({super.key});

  @override
  State<Safety> createState() => _SafetyState();
}

class _SafetyState extends State<Safety> {
  List<String> doctorMails = [];
  Future<void> fetchData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Reference to the Firestore collection containing doctor data
      final collectionReference = firestore.collection('listMedecins');

      // Query the collection to get the list of doctor names
      final querySnapshot = await collectionReference.get();

      // Extract the doctor names from the query snapshot
      final mails =
          querySnapshot.docs.map((doc) => doc['email'] as String).toList();

      // Update the state with the list of doctor names
      setState(() {
        doctorMails = mails;
      });
    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menu.png'),
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
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color(0xFFD37777),
                ),
                backgroundColor: Colors.grey[100],
              ),
            ),
            Text(
              'Safety & Privacy',
              style: TextStyle(
                fontSize: screenSize.width * 0.08,
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.09,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  screenSize.width * 0.05, 0, screenSize.width * 0.09, 0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Protecting Your Privacy And Information:',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      fontFamily: 'Oswald',
                      letterSpacing: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Container(
                    height: screenSize.height * 0.525,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenSize.width * 0.02, 0, 0, 0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '  At Optimum, your privacy is our top priority. We want you to feel confident that any personal information you share with us is handled securely and with the utmost care. We have implemented stringent measures to ensure the protection of your data.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Oswald',
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Text(
                              '  Your personal information, such as Your Name, Your Address, Your Phone Number, Your Picture and Your Medical Information, is collected solely for the purpose of providing you with a seamless experience within our app. We will never share, sell, or disclose your personal information to any third party without your explicit consent, except where required by law.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Oswald',
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Text(
                              '  We employ industry-standard encryption and security protocols to safeguard your data from unauthorized access, alteration, or disclosure. Our team regularly reviews and updates our security practices to ensure that your information remains confidential.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Oswald',
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Text(
                              '  Please note that while we take every precaution to protect your data, no method of transmission over the internet or electronic storage is 100% secure. Therefore, we cannot guarantee absolute security. By using our app, you acknowledge and accept this limitation.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Oswald',
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Text(
                              '  To enhance your experience and enable specific app features, we may request your permission to access certain device functions or information. Granting this permission is entirely voluntary, and you have the freedom to choose which permissions to allow or deny. Rest assured that we will only access the requested permissions for the intended purposes of the app\'s functionality.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Oswald',
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Text(
                              '  By continuing to use our app, you consent to the collection, storage, and processing of your personal information as outlined in this privacy message.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Oswald',
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Text(
                              '  If you have any concerns or questions about our privacy practices, please contact us at lorgin@gmail.com. We value your trust and are committed to protecting your privacy.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Oswald',
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Text(
                              'Thank you for choosing Optimum.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Oswald',
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Container(
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.065,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Color(0xFFD37777);
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Wrapper(
                              doctorsList: doctorMails,
                            )),
                  );
                },
                child: Text(
                  'AGREE',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Oswald',
                    fontSize: screenSize.height * 0.03,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
