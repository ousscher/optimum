import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user.dart';
import '../services/database.dart';


class MedsListt extends StatefulWidget {

  MedsListt({super.key});

  @override
  State<MedsListt> createState() => _MedsListState();
}

class _MedsListState extends State<MedsListt> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Medecin>?>.value(
      initialData: null,
      value: DatabaseService.meds,
      child: Doctors(),
    );
  }
}

class Doctors extends StatefulWidget {
  const Doctors({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  final List<Widget> _pages = [];
  @override
  Widget build(BuildContext context) {
    final medecins = Provider.of<List<Medecin>?>(context);
    print(medecins);
    if (medecins != null) {
      medecins.forEach((element) {
        setState(() {
          _pages.add(DoctorOne(medecin: element));
        });
      });
    }
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page){
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index){
              return _pages[index % _pages.length];
            },
          ),
          Positioned(
            bottom: screenSize.height * 0.03 ,
            left: 0,
            right: 0,
            height: screenSize.height * 0.01,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    _pages.length,
                        (index) => InkWell(
                            onTap: (){
                              _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: screenSize.width * 0.05,
                              backgroundColor: _activePage == index ? Color(0xFFD37777) : Color(0xFFD9D9D9),
                            ),

                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorOne extends StatelessWidget {
  Medecin? medecin;
   DoctorOne({super.key, required this.medecin});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    print(medecin!.getName());
    print(medecin!.getLastName());
    print(medecin!.getEmail());
    print(medecin!.getPhone());
    print(medecin!.getProfessionalCarrer());
    print(medecin!.getSpecialite());
    print(medecin!.getAttendence());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/drprin.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, screenSize.height * 0.06, screenSize.width * 0.7, 0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFFD37777),
                  ),
                  backgroundColor: Theme.of(context).shadowColor,
                ),
              ),
              SizedBox(height: screenSize.height * 0.295,),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, screenSize.width * 0.07, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.15,
                      height: screenSize.width * 0.15,
                      child: TextButton(
                        onPressed:
                          () async {
                            String? encodeQueryParameters(Map<String, String> params) {
                              return params.entries
                                  .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&');
                            }
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: '${medecin!.getEmail()}',
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Patient Question',
                              }),
                            );
                            try{
                              await launchUrl(emailUri);
                            }catch(e){
                              print(e.toString());
                            }
                        },
                        child:Image.asset(
                          'assets/images/email_icon.png',
                          width: screenSize.width * 0.1 ,
                          height: screenSize.height * 0.1 ,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Theme.of(context).shadowColor;
                            },
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.04,),
                    Container(
                      width: screenSize.width * 0.15,
                      height: screenSize.width * 0.15,
                      child: TextButton(
                        onPressed: () async {

                          final Uri phoneUri = Uri(
                            scheme: 'tel',
                            path: '${medecin!.getPhone()}',
                          );
                          try{
                            await launchUrl(phoneUri);
                          }catch(e){
                            print(e.toString());
                          }
                        },
                        child: Image.asset(
                          'assets/images/phone_icon.png',
                          width: screenSize.width * 0.07 ,
                          height: screenSize.height * 0.07 ,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Theme.of(context).shadowColor;
                            },
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                      Icons.chevron_left_sharp,
                      color: Color(0xFFD37777),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Dr. ${medecin!.getName()} ${medecin!.getLastName()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.height * 0.035,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald',
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.003,),
                      Text(
                        medecin!.getSpecialite() ?? 'Doctor',
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: screenSize.height * 0.02,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.011,),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Color(0xFFD37777),
                          ),
                          SizedBox(width: screenSize.width * 0.005,),
                          Icon(
                            Icons.star,
                            color: Color(0xFFD37777),
                          ),
                          SizedBox(width: screenSize.width * 0.005,),
                          Icon(
                            Icons.star,
                            color: Color(0xFFD37777),
                          ),
                          SizedBox(width: screenSize.width * 0.005,),
                          Icon(
                            Icons.star,
                            color: Color(0xFFD37777),
                          ),
                          SizedBox(width: screenSize.width * 0.005,),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.03,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'About',
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: screenSize.height * 0.025,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01,),
                          Container(
                            height: screenSize.height * 0.12,
                            width: screenSize.width * 0.8,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${medecin!.getProfessionalCarrer()}',
                                    style: TextStyle(
                                      color: Color(0xFFD9D9D9),
                                      fontSize: screenSize.height * 0.015,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.03,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(screenSize.width * 0.2, 0, 0, 0),
                        child: Container(
                          height: screenSize.height * 0.06,
                          width: screenSize.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: (medecin!.getAttendence() == 'present')? Color(0xFF00CC66) : Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              medecin!.getAttendence() ?? 'Default',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.height * 0.023,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenSize.width * 0.02,),
                  Icon(
                      Icons.navigate_next_sharp,
                      color: Color(0xFFD37777),
                    ),
                ],
              ),
            ],
        ),
        ),
      );
  }
}
