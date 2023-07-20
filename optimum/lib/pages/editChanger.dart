import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/edit_medical_profile_page.dart';
import 'package:optimum/pages/edit_pesonal_profile_page.dart';

class EditChanger extends StatefulWidget {
  Patient? malade;
  EditChanger({super.key, required this.malade});

  @override
  State<EditChanger> createState() => _EditChangerState();
}

class _EditChangerState extends State<EditChanger> {
  bool showEditProfil = true;
  void toogleview() {
    setState(() {
      showEditProfil = !showEditProfil;
    });
  }

  // void updateUser(Patient? updatedUser) {
  //   setState(() {
  //     widget.malade = updatedUser;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (showEditProfil) {
      return Editpersonal(
        toggleview: toogleview,
        updateUser: (updatedUser) {
          setState(() {
            widget.malade = updatedUser;
          });
        },
        malade: widget.malade,
      );
    } else {
      return Editmedical(
        toggleview: toogleview,
        updateUser: (updatedUser) {
          setState(() {
            widget.malade = updatedUser;
          });
        },
        malade: widget.malade,
      );
    }
  }
}
