// @dart=2.9

import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:teen_hacks/bezier_Container.dart';
import 'package:teen_hacks/home.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _userType = TextEditingController();
  TextEditingController _phone = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  ImagePicker picker = ImagePicker();
  File image;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white70,
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 150, left: 20),
                      child:
                          // Text('Login',
                          //     style: GoogleFonts.poppins(
                          //         fontSize: 40,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black87)),
                          GradientText(
                              text: "SignUp",
                              colors: [Colors.blue, Colors.lightBlueAccent],
                              style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Please signup to continue',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(4288914861))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 30, right: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Name',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                color: Colors.blue, fontSize: 18),
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
                                  controller: _name,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.25),
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
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
                              'Email',
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
                              borderRadius: BorderRadius.circular(10),
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
                                ),
                              ),
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
                              borderRadius: BorderRadius.circular(10),
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
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Age',
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
                                controller: _age,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  fillColor: Colors.grey.withOpacity(0.25),
                                  filled: true,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'User Type',
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
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                controller: _userType,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  fillColor: Colors.grey.withOpacity(0.25),
                                  filled: true,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.person_pin,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Phone Number',
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
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                controller: _phone,
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
                                    Icons.phone,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Profile Photo',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final pickedFile = await ImagePicker.pickImage(
                                source: ImageSource.camera);
                            if (pickedFile != null) {
                              setState(() {
                                image = File(
                                  pickedFile.path,
                                );
                              });
                            }
                          },
                          child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.3)),
                              child: image == null
                                  ? Icon(
                                      Icons.upload_file,
                                      color: Colors.blue.withOpacity(0.8),
                                      size: 100,
                                    )
                                  : Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(image),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                    )),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async {
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child('${DateTime.now()}user_image');

                              await ref.putFile(image).onComplete;
                              String imgurl = await ref.getDownloadURL();
                              print("Image URL: " + imgurl);
                              auth
                                  .createUserWithEmailAndPassword(
                                      email: _username.text,
                                      password: _password.text)
                                  .then((value) {
                                Firestore.instance
                                    .collection('users')
                                    .document(value.user.uid)
                                    .setData({
                                  "userType": _userType.text.toLowerCase()
                                });
                                _userType.text == "Patient"
                                    ? Firestore.instance
                                        .collection("patient")
                                        .document(value.user.uid)
                                        .setData({
                                        "age": _age.text,
                                        "profile_pic": imgurl,
                                        "phone": _phone.text,
                                        "name": _name.text,
                                        "userType": _userType.text.toLowerCase()
                                      })
                                    : Firestore.instance
                                        .collection("doctor")
                                        .document(value.user.uid)
                                        .setData({
                                        "age": _age.text,
                                        "profile_pic": imgurl,
                                        "name": _name.text,
                                        "phone": _phone.text,
                                        "userType": _userType.text.toLowerCase()
                                      });
                                print("Done Cool");
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => Home(value.user.uid)),
                                    (route) => false);
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                      colors: [
                                        Colors.blue,
                                        Colors.lightBlueAccent
                                      ])),
                              child: Text('SignUp',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
