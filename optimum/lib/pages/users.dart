import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optimum/models/user.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserOptimum>?>(context);
    // print("----------------------   $users -------------------"); /
    if (users != null) {
      users.forEach((element) {
        print(element.getName());
        print(element.getLastName());
      });
    }
    return Container();
  }
}
