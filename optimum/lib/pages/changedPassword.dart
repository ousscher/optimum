import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:optimum/pages/Wrapper.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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
                    builder: (context) => Wrapper(doctorsList: doctorMails,),
                  ));;
            },
            child: Text("ok"))
      ]),
    );
  }
}
