import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:optimum/models/user.dart';
import 'package:optimum/pages/edit_pesonal_profile_page.dart';
import 'package:optimum/pages/profile.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class Editmedical extends StatefulWidget {
  final Function toggleview;
  final Function updateUser;
  Patient? malade;
  Editmedical(
      {super.key,
      required this.toggleview,
      required this.updateUser,
      required this.malade});
  @override
  State<Editmedical> createState() => _EditmedicalState();
}

class _EditmedicalState extends State<Editmedical> {
  final _formKey = GlobalKey<FormState>();
  String height = "";
  String weight = "";
  List<Widget> additionalSurgeryCodeSections = [];
  List<Widget> additionalChronicCodeSections = [];
  void initSurgerySections(dynamic screenSize) {
    widget.malade!.getSurgery()!.forEach((element) {
      setState(() {
        additionalSurgeryCodeSections.add(
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.3,
                  ),
                  Container(
                    width: screenSize.width * 0.6,
                    height: screenSize.height * 0.068,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.grey.shade50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyDropdownPageee(
                        patient: widget.malade,
                        hint: element,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
            ],
          ),
        );
      });
    });
  }

  void initChronicSections(dynamic screenSize) {
    widget.malade!.getCronicDesease()!.forEach((element) {
      additionalChronicCodeSections.add(
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenSize.width * 0.3,
                ),
                Container(
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.068,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.grey.shade50,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyDropdownPageeee(
                      patient: widget.malade,
                      hint: element,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
          ],
        ),
      );
    });
  }

  void addSurgerySection() {
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      additionalSurgeryCodeSections.add(
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenSize.width * 0.3,
                ),
                Container(
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.068,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.grey.shade50,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyDropdownPageee(
                      patient: widget.malade,
                      hint: "Not mentionned",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
          ],
        ),
      );
    });
  }

  void addChronicSection() {
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      additionalChronicCodeSections.add(
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenSize.width * 0.3,
                ),
                Container(
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.068,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.grey.shade50,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyDropdownPageeee(
                      patient: widget.malade,
                      hint: "Not Mentionned",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weight = widget.malade!.getWeight() ?? "";
    height = widget.malade!.getHeight() ?? "";
  }

  Widget build(BuildContext context) {
    final img = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
        ? 'edit_profile_dark'
        : 'edit_profile';
    final screenSize = MediaQuery.of(context).size;
    initSurgerySections(screenSize);
    initChronicSections(screenSize);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/' + '$img' + '.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, screenSize.height * 0.04, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            widget.toggleview();
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.navigate_before,
                                color: Color(0xFFD37777),
                                size: 30.0,
                              ),
                              Text(
                                'BACK',
                                style: TextStyle(
                                  color: Color(0xFFD37777),
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.08,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(screenSize.width * 0.014, 0, 0, 0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: screenSize.height * 0.06,
                        ),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: screenSize.height * 0.0579,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, screenSize.height * 0.04, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                widget.malade!.setHeight(height);
                                widget.malade!.setWeight(weight);
                              });
                              Navigator.pop(context, widget.malade);
                            }
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                'DONE',
                                style: TextStyle(
                                  color: Color(0xFFD37777),
                                  fontSize: screenSize.height * 0.025,
                                  fontFamily: 'Oswald',
                                ),
                              ),
                              Icon(
                                Icons.navigate_next_sharp,
                                color: Color(0xFFD37777),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.08,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.075,
              ),
              Text(
                'Fill In This Form So The Dr Can Diagnose Your Disease',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: screenSize.height * 0.017,
                  letterSpacing: 1.0,
                  color: Color(0xFFD9D9D9),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.0065,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenSize.width * 0.05, 0, screenSize.width * 0.05, 0),
                child: Divider(
                  height: screenSize.height * 0.01,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.007,
              ),
              Text(
                'Medical Information',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: screenSize.height * 0.03,
                  letterSpacing: 1.0,
                  color: Color(0xFFD37777),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.007,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenSize.width * 0.05, 0, screenSize.width * 0.05, 0),
                child: Divider(
                  height: screenSize.height * 0.01,
                  color: Colors.grey[500],
                ),
              ),
              Container(
                height: screenSize.height * 0.582,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: screenSize.height * 0.008),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Blood Type',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: screenSize.height * 0.023,
                                        color: Color(0xFF66B3FF),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.06,
                                    ),
                                    Container(
                                      width: screenSize.width * 0.6,
                                      height: screenSize.height * 0.068,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFD9D9D9)),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MyDropdownPage(
                                          patient: widget.malade,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '   Weight',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: screenSize.height * 0.023,
                                        color: Color(0xFF66B3FF),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.11,
                                    ),
                                    Container(
                                      width: screenSize.width * 0.6,
                                      height: screenSize.height * 0.068,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: TextFormField(
                                        initialValue:
                                            (widget.malade!.getWeight()) ?? "",
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          weight = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Weight',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFD9D9D9)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFD9D9D9)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFD9D9D9)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '   Height',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: screenSize.height * 0.023,
                                        color: Color(0xFF66B3FF),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.12,
                                    ),
                                    Container(
                                      width: screenSize.width * 0.6,
                                      height: screenSize.height * 0.068,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: TextFormField(
                                        initialValue:
                                            widget.malade!.getHeight() ?? "",
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          height = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Height',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFD9D9D9)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFD9D9D9)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFD9D9D9)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '  Allergic',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: screenSize.height * 0.023,
                                        color: Color(0xFF66B3FF),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.11,
                                    ),
                                    Container(
                                      width: screenSize.width * 0.6,
                                      height: screenSize.height * 0.068,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFD9D9D9)),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MyDropdownPagee(
                                          patient: widget.malade,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '  Surgery',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: screenSize.height * 0.023,
                                        color: Color(0xFF66B3FF),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.1,
                                    ),
                                    Container(
                                      width: screenSize.width * 0.6,
                                      height: screenSize.height * 0.068,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFD9D9D9)),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MyDropdownPageee(
                                          patient: widget.malade,
                                          hint: "New surgery",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      screenSize.width * 0.7, 0, 0, 0),
                                  child: Container(
                                    height: screenSize.width * 0.1,
                                    child: TextButton(
                                      onPressed: addSurgerySection,
                                      child: Text(
                                        'ADD+',
                                        style: TextStyle(
                                          color: Color(0xFFD9D9D9),
                                          fontFamily: 'Poppins',
                                          fontSize: screenSize.height * 0.02,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: additionalSurgeryCodeSections,
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          ' Chronic',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: screenSize.height * 0.023,
                                            color: Color(0xFF66B3FF),
                                          ),
                                        ),
                                        Text(
                                          ' Disease',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: screenSize.height * 0.023,
                                            color: Color(0xFF66B3FF),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.08,
                                    ),
                                    Container(
                                      width: screenSize.width * 0.6,
                                      height: screenSize.height * 0.068,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFD9D9D9)),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MyDropdownPageeee(
                                          patient: widget.malade,
                                          hint: "New Chronic Disease",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      screenSize.width * 0.7, 0, 0, 0),
                                  child: Container(
                                    height: screenSize.width * 0.1,
                                    child: TextButton(
                                      onPressed: addChronicSection,
                                      child: Text(
                                        'ADD+',
                                        style: TextStyle(
                                          color: Color(0xFFD9D9D9),
                                          fontFamily: 'Poppins',
                                          fontSize: screenSize.height * 0.02,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: additionalChronicCodeSections,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.051,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDropdownPage extends StatefulWidget {
  Patient? patient;
  MyDropdownPage({super.key, required this.patient});
  @override
  _MyDropdownPageState createState() => _MyDropdownPageState();
}

class _MyDropdownPageState extends State<MyDropdownPage> {
  String? _dropdownValue;
  static const list1 = [
    DropdownMenuItem(child: Text("Not Mentioned"), value: "Not Mentioned"),
    DropdownMenuItem(child: Text("A-"), value: "A-"),
    DropdownMenuItem(child: Text("A+"), value: "A+"),
    DropdownMenuItem(child: Text("B-"), value: "B-"),
    DropdownMenuItem(child: Text("B+"), value: "B+"),
    DropdownMenuItem(child: Text("O-"), value: "O-"),
    DropdownMenuItem(child: Text("O+"), value: "O+"),
    DropdownMenuItem(child: Text("AB-"), value: "AB-"),
    DropdownMenuItem(child: Text("AB+"), value: "AB+"),
  ];

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
        if (selectedValue == "Not Mentioned") {
          widget.patient!.setBloodType(null);
        } else
          widget.patient!.setBloodType(selectedValue);
      });

      // Print the selected value

      print("Selected value: $_dropdownValue");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.patient!.getBloodType());
  }

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
          child: DropdownButton(
            items: list1,
            value: _dropdownValue,
            onChanged: dropdownCallback,
            isExpanded: true,
            borderRadius: BorderRadius.circular(20.0),
            iconEnabledColor: Color(0xFFD37777),
            iconSize: 26.0,
            icon: Icon(
              Icons.arrow_drop_down_circle_outlined,
              color: Color(0xFFD37777),
            ),
            hint: widget.patient!.getBloodType() == null
                ? Text("Not Mentionned")
                : Text("${widget.patient!.getBloodType()}"),
          ),
        ),
      ),
    );
  }
}

class MyDropdownPagee extends StatefulWidget {
  Patient? patient;
  MyDropdownPagee({super.key, required this.patient});
  @override
  _MyDropdownPageeState createState() => _MyDropdownPageeState();
}

class _MyDropdownPageeState extends State<MyDropdownPagee> {
  String? _dropdownValuee;

  static const list2 = [
    DropdownMenuItem(child: Text("Not Mentioned"), value: "Not Mentioned"),
    DropdownMenuItem(child: Text("Allergic"), value: "Allergic"),
    DropdownMenuItem(child: Text("Not Allergic"), value: "Not Allergic"),
  ];

  void dropdownCallbackk(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValuee = selectedValue;
        if (selectedValue == "Not Mentioned") {
          widget.patient!.setAlergic(null);
        } else {
          widget.patient!.setAlergic(selectedValue);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
          child: DropdownButton(
              items: list2,
              value: _dropdownValuee,
              onChanged: dropdownCallbackk,
              isExpanded: true,
              borderRadius: BorderRadius.circular(20.0),
              iconEnabledColor: Color(0xFFD37777),
              iconSize: 26.0,
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Color(0xFFD37777),
              ),
              hint: widget.patient!.getAlergic() == null
                  ? Text('Not Metioned')
                  : Text(widget.patient!.getAlergic()!)),
        ),
      ),
    );
  }
}

class MyDropdownPageee extends StatefulWidget {
  Patient? patient;
  String hint;
  MyDropdownPageee({super.key, required this.patient, required this.hint});
  @override
  _MyDropdownPageeeState createState() => _MyDropdownPageeeState();
}

class _MyDropdownPageeeState extends State<MyDropdownPageee> {
  String? _dropdownValueee;
  static const list3 = [
    DropdownMenuItem(child: Text("Not Mentioned"), value: "Not Mentioned"),
    DropdownMenuItem(child: Text("Appendectomy"), value: "Appendectomy"),
    DropdownMenuItem(child: Text("Cataract"), value: "Cataract"),
    DropdownMenuItem(child: Text("Heart"), value: "Heart"),
    DropdownMenuItem(child: Text("Brain"), value: "Brain"),
    DropdownMenuItem(child: Text("Cholecystectomy"), value: "Cholecystectomy"),
    DropdownMenuItem(child: Text("Hysterectomy"), value: "Hysterectomy"),
    DropdownMenuItem(child: Text("Other"), value: "Other"),
  ];

  void dropdownCallbackkk(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValueee = selectedValue;
        if (widget.p(atient!.getSurgery)!.contains(widget.hint)) {
          widget.patient!.getSurgery()!.remove(widget.hint);
        }
        widgetlue.hint = selectedVa;
        if (selectedValue != "Not Mentioned") {
          //delete the old value
          if (!widget.patient!.getSurgery()!.contains(selectedValue))
            widget.patient!.addSurgery(selectedValue);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
          child: DropdownButton(
              items: list3,
              value: _dropdownValueee,
              onChanged: dropdownCallbackkk,
              isExpanded: true,
              borderRadius: BorderRadius.circular(20.0),
              iconEnabledColor: Color(0xFFD37777),
              iconSize: 26.0,
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Color(0xFFD37777),
              ),
              hint: Text(widget.hint)),
        ),
      ),
    );
  }
}

class MyDropdownPageeee extends StatefulWidget {
  Patient? patient;
  String hint;
  MyDropdownPageeee({super.key, required this.hint, required this.patient});
  @override
  _MyDropdownPageeeeState createState() => _MyDropdownPageeeeState();
}

class _MyDropdownPageeeeState extends State<MyDropdownPageeee> {
  String? _dropdownValueeee;
  static const list4 = [
    DropdownMenuItem(child: Text("Not Mentioned"), value: "Not Mentioned"),
    DropdownMenuItem(child: Text("ALS"), value: "ALS"),
    DropdownMenuItem(child: Text("Alzheimer"), value: "Alzheimer"),
    DropdownMenuItem(child: Text("Asthma"), value: "Asthma"),
    DropdownMenuItem(child: Text("Cancer"), value: "Cancer"),
    DropdownMenuItem(child: Text("Cystic Fibrosis"), value: "Cystic Fibrosis"),
    DropdownMenuItem(child: Text("Diabetes"), value: "Diabetes"),
    DropdownMenuItem(child: Text("Other"), value: "Other"),
  ];

  void dropdownCallbackkkk(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValueeee = selectedValue;
        if (widget.patient!.getCronicDesease()!.contains(widget.hint)) {
          widget.patient!.getCronicDesease()!.remove(widget.hint);
        }
        widget.hint = selectedValue;
        if (selectedValue != "Not Mentioned") {
          if (!widget.patient!.getCronicDesease()!.contains(selectedValue))
            widget.patient!.addChronicDisease(selectedValue);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
          child: DropdownButton(
            items: list4,
            value: _dropdownValueeee,
            onChanged: dropdownCallbackkkk,
            isExpanded: true,
            borderRadius: BorderRadius.circular(20.0),
            iconEnabledColor: Color(0xFFD37777),
            iconSize: 26.0,
            icon: Icon(
              Icons.arrow_drop_down_circle_outlined,
              color: Color(0xFFD37777),
            ),
            hint: Text(widget.hint),
          ),
        ),
      ),
    );
  }
}
