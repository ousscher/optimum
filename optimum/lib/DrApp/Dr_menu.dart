import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimum/DrApp/Dr_create_account.dart';
import 'package:optimum/DrApp/remove_dr.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:optimum/pages/start.dart';
import 'package:optimum/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/auth.dart';
import 'Dr_home_page.dart';

class DrMenu extends StatefulWidget {
  Patient? malade;
  DrMenu({super.key, required this.malade});

  @override
  State<DrMenu> createState() => _DrMenuState();
}

class _DrMenuState extends State<DrMenu> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    User? utilisateur = AuthService.getAuth().currentUser;
    final text =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
            ? 'Light Mode'
            : 'Dark Mode';
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'menu_dark'
        : 'menu';

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
                    MaterialPageRoute(builder: (context) => DrHome()),
                  );
                }, // Menu button
                child: Icon(
                  Icons.close,
                  color: Color(0xFFD37777),
                ),
                backgroundColor: Theme.of(context).shadowColor,
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
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.15,
                  screenSize.width * 0.1, screenSize.width * 0.15, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  // (utilisateur!.email == "lo_cherguelaine@esi.dz")
                      // ?
                      Column(
                          children: [
                            Divider(
                              height: screenSize.height * 0.01,
                              color: Colors.grey[500],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Drcreateaccount()),
                                );
                              },
                              child: Text(
                                'Add A Dr',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Removedr()),
                                );
                              },
                              child: Text(
                                'Remove A Dr',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: screenSize.width * 0.05,
                                  fontFamily: 'Oswald',
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.005,
                            ),
                          ],
                        ),
                      // : Container(),
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
                        color: Theme.of(context).primaryColor,
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
                    onPressed: () {
                      value = !value;
                      final provider =
                          Provider.of<ThemeProvider>(context, listen: false);
                      provider.toggleTheme(value);
                      if (value == false) {
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Lights turned OFF!',
                            message:
                                'You are in the Dark Mode. Enjoy our Optimum application!',
                            contentType: ContentType.success,
                          ),
                        );

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Lights turned ON!',
                            message:
                                'You are in the Light Mode. Protect your eyes!',
                            contentType: ContentType.warning,
                          ),
                        );

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      '$text',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).primaryColor,
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
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Signed Out!',
                          message:
                              'Good Bye, see you next time. May ALLAH bless you! ',
                          contentType: ContentType.success,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
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
