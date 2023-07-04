import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/Wrapper.dart';
import 'package:optimum/services/auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Optimum"),
        backgroundColor: Colors.brown[400],
        elevation: 0,
        actions: <Widget>[
          ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color?>(Colors.transparent),
              ),
              onPressed: () async {
                await AuthService.signOut();
                  Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Wrapper()),
              (Route<dynamic> route) => false, // Supprime toutes les routes précédentes
            );
              },
              icon: Icon(Icons.person),
              label: Text('logout'))
        ],
      ),
    );
  }
}
