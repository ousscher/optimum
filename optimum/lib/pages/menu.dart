import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/home_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:optimum/pages/start.dart';
import 'package:optimum/pages/feedback.dart';
import 'package:optimum/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/auth.dart';

class Menu extends StatefulWidget {
  Patient? malade;
  Menu({super.key, required this.malade});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
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
                    context,widget.malade
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
            InkWell(
              onTap: ()async {
                    Patient? p = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              patient: widget.malade,
                            )),
                  );
                  if (p != null) {
                    setState(() {
                      widget.malade = p;
                    });
                  }
                  },
               child: Container(
                width: screenSize.width * 0.26,
                height: screenSize.width * 0.26,
                child: (widget.malade!.getUrlPhoto() !=null)?
                  ClipOval(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/profil_pic.png'), // Image de remplacement pendant le chargement.
                      image:NetworkImage(widget.malade!.getUrlPhoto()!)  ,
                      fit: BoxFit.cover,
                      ),
                  ):Image(image: AssetImage("assets/images/profil_pic.png"))
                
              //   child: widget.malade!.getUrlPhoto() == null ?
              //   AssetImage('assets/images/profil_pic.png'):
              //   ,
                // decoration: BoxDecoration(
                //   // borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                //   border: Border.all(
                //     width: 2.0,
                //     color: Color(0xFFD37777),
                //   ),
                //   shape: BoxShape.circle,
                //   image:DecorationImage(
                //     image: widget.malade!.getUrlPhoto() == null
                //     ? AssetImage('assets/images/profil_pic.png')
                //     :Image.network(widget.malade!.getUrlPhoto()!).image,
                //     fit: BoxFit.cover
                //   ),
                // ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.005,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            patient: widget.malade,
                          )),
                );
              },
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
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
                    onPressed: () async {
                      final Uri mapsUri = Uri(
                        scheme: 'https',
                        host: 'www.google.dz',
                        path:
                            'maps/place/Grande+Poste+d\'Alger/@36.7729353,3.0590101,19z/data=!4m6!3m5!1s0x128fb2f7afffd155:0x1f9fda77ca70e32f!8m2!3d36.7729353!4d3.0594429!16s%2Fg%2F1jgm1x08z?entry=ttu',
                      );
                      try {
                        await launchUrl(mapsUri);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Text(
                      'Location',
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
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'English Mode!',
                          message:
                          'Our app currently only supports English; other languages have not been added yet',
                          contentType: ContentType.failure,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => feedback()),
                      );
                    },
                    child: Text(
                      'Feedback',
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
