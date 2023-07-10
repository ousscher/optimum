import 'package:flutter/material.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/start.dart';
import '../services/auth.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
                }, // Menu button
                child: Icon(
                  Icons.close,
                  color: Color(0xFFD37777),
                ),
                backgroundColor: Colors.grey[100],
              ),
            ),
            Text(
              'MENU',
              style: TextStyle(
                fontSize: screenSize.width * 0.11,
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.08,
            ),
            Container(
              width: screenSize.width * 0.26,
              height: screenSize.width * 0.26,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.white;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenSize.width * 0.15),
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/images/profil_pic.png',
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.005,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Profil',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenSize.width * 0.05,
                  fontFamily: 'Oswald',
                  letterSpacing: 1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.15,
                  screenSize.width * 0.1, screenSize.width * 0.15, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Booking History',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.width * 0.05,
                        fontFamily: '0swald',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Language',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.width * 0.05,
                        fontFamily: 'Oswald',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.width * 0.05,
                        fontFamily: 'Oswald',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Help',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.width * 0.05,
                        fontFamily: 'Oswald',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () async {
                      await AuthService.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Start()),
                        (Route<dynamic> route) =>
                            false, // Supprime toutes les routes précédentes
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.logout,
                          color: Color(0xFFD37777),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.02,
                        ),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: Color(0xFFD37777),
                            fontSize: screenSize.width * 0.05,
                            fontFamily: 'Poppins',
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Divider(
                    height: screenSize.height * 0.01,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
