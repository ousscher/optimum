import 'package:flutter/material.dart';


class Sign extends StatefulWidget {

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sign.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 240.0, 30.0, 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 170, 0),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color(0xFF66B3FF),
                    fontSize: 40.0,
                    letterSpacing: 2.0,
                    fontFamily: 'Oswald',
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                        color: Color(0xFFD9D9D9),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                        color: Color(0xFFD9D9D9),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                        color: Color(0xFFD9D9D9),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                      color: Color(0xFFD9D9D9),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                      color: Color(0xFFD9D9D9),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                      color: Color(0xFFD9D9D9),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(130.0, 0, 0, 0),
                child: TextButton(
                  onPressed: (){},
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: 15.0,
                      fontFamily: 'Poppins',
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Container(
                width: 280.0,
                height: 60.0,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFFD37777);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onPressed: (){},
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Oswald',
                      fontSize: 30.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Dont have Account?',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Poppins',
                        letterSpacing: 1,
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/createaccount');
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Color(0xFF66B3FF),
                            fontSize: 13.0,
                            fontFamily: 'Poppins',
                            letterSpacing: 1,
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
