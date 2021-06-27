// @dart=2.9

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:teen_hacks/bezier_Container.dart';
import 'package:teen_hacks/home.dart';
import 'package:teen_hacks/signinup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return
        // Scaffold(
        //   body: Container(
        //     width: double.infinity,
        //     height: double.infinity,
        //     decoration: BoxDecoration(
        //       color: Color(4278656558),
        //     ),
        //     child: SingleChildScrollView(
        //       child: Stack(
        //         children: [
        //           Align(
        //               alignment: Alignment.topRight,
        //               child:
        //                   Image.asset("assets/blob.png", height: 220, width: 220)),
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Padding(
        //                   padding: const EdgeInsets.only(top: 200, right: 210),
        //                   child:
        //                       // Text('Login',
        //                       //     style: GoogleFonts.poppins(
        //                       //         fontSize: 40,
        //                       //         fontWeight: FontWeight.bold,
        //                       //         color: Colors.black87)),
        //                       GradientText(
        //                           text: "Login",
        //                           colors: [Colors.blue, Colors.lightBlueAccent],
        //                           style: GoogleFonts.poppins(
        //                               fontSize: 40,
        //                               fontWeight: FontWeight.bold,
        //                               color: Colors.black87))),
        //               Padding(
        //                 padding: const EdgeInsets.only(right: 125),
        //                 child: Text('Please login to continue',
        //                     style: GoogleFonts.poppins(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 15,
        //                         color: Color(4288914861))),
        //               ),
        //               SizedBox(
        //                 height: 40,
        //               ),
        //               Padding(
        //                 padding:
        //                     const EdgeInsets.only(top: 8.0, left: 30, right: 30),
        //                 child: Column(
        //                   children: [
        //                     Align(
        //                       alignment: Alignment.bottomLeft,
        //                       child: Text(
        //                         'Username',
        //                         textAlign: TextAlign.start,
        //                         style: GoogleFonts.poppins(
        //                             color: Color(4288914861), fontSize: 18),
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       height: 5,
        //                     ),
        //                     Material(
        //                       borderRadius: BorderRadius.circular(10.0),
        //                       elevation: 2,
        //                       color: Colors.white,
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           borderRadius: BorderRadius.circular(10.0),
        //                           // boxShadow: [
        //                           //   BoxShadow(
        //                           //     color: Colors.black12,
        //                           //     blurRadius: 6.0,
        //                           //     offset: Offset(0, 2),
        //                           //   ),
        //                           // ],
        //                         ),
        //                         child: TextFormField(
        //                             controller: _username,
        //                             decoration: InputDecoration(
        //                               border: InputBorder.none,
        //                               focusedBorder: InputBorder.none,
        //                               enabledBorder: InputBorder.none,
        //                               errorBorder: InputBorder.none,
        //                               disabledBorder: InputBorder.none,
        //                               contentPadding: EdgeInsets.only(top: 14.0),
        //                               prefixIcon: Icon(
        //                                 Icons.email_outlined,
        //                                 color: Color(4288914861),
        //                               ),
        //                             )),
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       height: 20,
        //                     ),
        //                     Align(
        //                         alignment: Alignment.bottomLeft,
        //                         child: Text(
        //                           'Password',
        //                           style: GoogleFonts.poppins(
        //                               color: Color(4288914861), fontSize: 18),
        //                         )),
        //                     SizedBox(
        //                       height: 5,
        //                     ),
        //                     Material(
        //                       elevation: 3,
        //                       color: Colors.white,
        //                       borderRadius: BorderRadius.circular(10.0),
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(10.0),
        //                         ),
        //                         child: TextFormField(
        //                           controller: _password,
        //                           decoration: InputDecoration(
        //                             border: InputBorder.none,
        //                             focusedBorder: InputBorder.none,
        //                             enabledBorder: InputBorder.none,
        //                             errorBorder: InputBorder.none,
        //                             disabledBorder: InputBorder.none,
        //                             contentPadding: EdgeInsets.only(top: 14.0),
        //                             prefixIcon: Icon(
        //                               Icons.lock_outline,
        //                               color: Color(4288914861),
        //                             ),
        //                           ),
        //                           obscureText: false,
        //                         ),
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       height: 40,
        //                     ),
        //                     Align(
        //                       alignment: Alignment.centerRight,
        //                       child: GestureDetector(
        //                         onTap: () async {
        //                           try {
        //                             auth
        //                                 .signInWithEmailAndPassword(
        //                                     email: _username.text,
        //                                     password: _password.text)
        //                                 .then(
        //                                     (value) => Navigator.pushAndRemoveUntil(
        //                                         context,
        //                                         MaterialPageRoute(
        //                                             builder: (ctx) => Home(
        //                                                 value.user.uid
        //                                                 )),
        //                                         (route) => false));
        //                           } catch (e) {
        //                             print(e);
        //                           }
        //                         },
        //                         child: Container(
        //                           height: 50,
        //                           width: 180,
        //                           child: Align(
        //                               alignment: Alignment.center,
        //                               child: Row(
        //                                 mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [
        //                                   Text(
        //                                     'Login ',
        //                                     style: GoogleFonts.poppins(
        //                                         fontSize: 20,
        //                                         fontWeight: FontWeight.bold,
        //                                         color: Colors.white),
        //                                   ),
        //                                   SizedBox(
        //                                     width: 10,
        //                                   ),
        //                                   Icon(
        //                                     Icons.arrow_forward_rounded,
        //                                     color: Colors.white,
        //                                   )
        //                                 ],
        //                               )),
        //                           decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(30),
        //                               gradient: LinearGradient(colors: [
        //                                 Colors.blue,
        //                                 Colors.lightBlueAccent
        //                               ])),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 100,
        //               ),
        //               GestureDetector(
        //                 onTap: () {
        //                   Navigator.push(context,
        //                       MaterialPageRoute(builder: (builder) => Signup()));
        //                 },
        //                 child: Align(
        //                   alignment: Alignment.bottomCenter,
        //                   child: Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Padding(
        //                         padding: const EdgeInsets.only(right: 0),
        //                         child: Text('Dont have an account ?',
        //                             style: GoogleFonts.poppins(
        //                                 fontWeight: FontWeight.bold,
        //                                 fontSize: 15,
        //                                 color: Color(4288914861))),
        //                       ),
        //                       GradientText(
        //                           text: "  SignUp",
        //                           colors: [Colors.blue, Colors.lightBlueAccent],
        //                           style: GoogleFonts.poppins(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 15,
        //                               color: Color(4288914861))),
        //                     ],
        //                   ),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );

        Scaffold(
            body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .17),
                  Padding(
                      padding: const EdgeInsets.only(top: 0, right: 0),
                      child:
                          // Text('Login',
                          //     style: GoogleFonts.poppins(
                          //         fontSize: 40,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black87)),
                          Align(
                        alignment: Alignment.bottomLeft,
                        child: GradientText(
                            text: "Login",
                            textAlign: TextAlign.start,
                            colors: [Colors.blue, Colors.lightBlueAccent],
                            style: GoogleFonts.poppins(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87)),
                      )),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 5),
                  //     child: Text('Please login to continue',
                  //         style: GoogleFonts.poppins(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 15,
                  //             color: Color(4288914861))),
                  //   ),
                  // ),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Username',
                      textAlign: TextAlign.start,
                      style:
                          GoogleFonts.poppins(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black12,
                        //     blurRadius: 6.0,
                        //     offset: Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextFormField(
                            controller: _username,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.grey.withOpacity(0.25),
                              filled: true,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.blue,
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Password',
                        style: GoogleFonts.poppins(
                            color: Colors.blue, fontSize: 18),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Material(
                    elevation: 0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextFormField(
                          controller: _password,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.25),
                            filled: true,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.blue,
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      try {
                        auth
                            .signInWithEmailAndPassword(
                                email: _username.text, password: _password.text)
                            .then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Home(value.user.uid)),
                                ));
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.blue, Colors.lightBlueAccent])),
                      child: Text('Login',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: height * .055),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Don\'t have an account ?',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
