import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../provider/theme_provider.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
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
                SizedBox(width: screenSize.width * 0.035,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Soltani Amine',
                      style: TextStyle(
                        color: Color(0xFF70A4EA),
                        fontFamily: 'Oswald',
                        fontSize: screenSize.width * 0.06,
                        letterSpacing: 1.0,
                      ),
                    ),

                    Text(
                      'From: 8:00AM To: 8:20AM',
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
                        SizedBox(width: screenSize.width * 0.04,),
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
        ),
      );
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
                SizedBox(width: screenSize.width * 0.175,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, screenSize.height * 0.045, 0, 0),
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
class MyDropdownPage extends StatefulWidget {


  MyDropdownPage( {super.key});
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