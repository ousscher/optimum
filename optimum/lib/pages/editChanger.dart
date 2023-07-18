import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:optimum/pages/edit_medical_profile_page.dart';
import 'package:optimum/pages/edit_pesonal_profile_page.dart';
import '../models/user.dart';

class EditChanger extends StatefulWidget {
  Patient malade;
  EditChanger({super.key, required this.malade});

  @override
  State<EditChanger> createState() => _EditChangerState();
}

class _EditChangerState extends State<EditChanger> {
  bool showProfile = false;
  void toggleview(){
    setState(() {
      this.showProfile = !this.showProfile;
    });
  }
  @override
  Widget build(BuildContext context) {
    return (this.showProfile) ? Editpersonal(toggleview: toggleview,) : Editmedical();
  }
}
