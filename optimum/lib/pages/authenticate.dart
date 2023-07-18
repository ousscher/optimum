//c'est la on retourne soit la page de sign in ou bien le registerPage

import 'package:optimum/pages/create_account_page.dart';
import 'package:optimum/pages/sign_page.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  bool showSignIn;
  Authenticate({super.key, required this.showSignIn});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  void toggleView() {
    setState(() {
      widget.showSignIn = !widget.showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.showSignIn == true ? Sign(toggleView: toggleView,) : Createaccount(toggleView: toggleView,);
  }
}
