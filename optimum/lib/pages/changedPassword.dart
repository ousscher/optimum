import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/Wrapper.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("changed password"),
      ),
      body: Column(children: [
        Text("suivre le lien dans votre boite mail pour reset the password"),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Wrapper(),
                  ));;
            },
            child: Text("ok"))
      ]),
    );
  }
}
