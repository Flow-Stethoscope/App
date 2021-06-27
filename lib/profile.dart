// @dart=2.9

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  String uid;
  Profile(this.uid);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  String userType;
  String age;
  String profile_pic;
  getuserType() async {
    await Firestore.instance
        .collection("users")
        .document(widget.uid)
        .get()
        .then((value) {
      setState(() {
        userType = value["userType"];
        print(userType);
        Firestore.instance
            .collection(userType)
            .document(widget.uid)
            .get()
            .then((value) {
          setState(() {
            name = value["name"];
            profile_pic = value["profile_pic"];
            age = value["age"];

            print(name);
            print(profile_pic);
            print(age);
          });
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  profile_pic == null ? "" : profile_pic)))),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:214,
                        child: Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(name == null ? "" : name,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "$age years old",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height:20),
              // Center(
              //   child: Stack(
              //     alignment: Alignment.bottomCenter,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(bottom: 20.0),
              //         child: Container(
              //             width: 150,
              //             height: 150,
              //             decoration: BoxDecoration(
              //                 image: DecorationImage(
              //                     image: NetworkImage(profile_pic == null
              //                         ? "https://coolbackgrounds.io/images/backgrounds/white/pure-white-background-85a2a7fd.jpg"
              //                         : profile_pic),
              //                     fit: BoxFit.cover),
              //                 borderRadius: BorderRadius.circular(
              //                   (15),
              //                 ))),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.only(),
              //         child: Container(
              //           width: 75,
              //           height: 45,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             color: Colors.indigo,
              //             // boxShadow: [
              //             //   BoxShadow(
              //             //     color: Colors.white.withOpacity(0.5),
              //             //     spreadRadius: 10,
              //             //     blurRadius: 20,
              //             //     offset:
              //             //         Offset(0, 3), // changes position of shadow
              //             //   ),
              //             // ],
              //           ),
              //           child: Icon(
              //             Icons.edit,
              //             color: Colors.white,
              //             size: 30,
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(name == null ? "" : name,
              //     // "Dhanush",
              //     style: GoogleFonts.poppins(
              //         fontSize: 27,
              //         height: 1.5,
              //         color: Colors.blue,
              //         fontWeight: FontWeight.w500)),
              // SizedBox(height: 0),
              // Text(
              //   age == null ? "" : "$age years",
              //   style: GoogleFonts.poppins(fontSize: 17, color: Colors.grey),
              // ),
              // SizedBox(height: 30),
              Text(
                userType == "doctor" ? "" : "Your Doctors",
                style: GoogleFonts.poppins(
                    // height:0,
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
              userType == null
                  ? Container()
                  : StreamBuilder(
                      stream: Firestore.instance
                          .collection("patient")
                          .document(widget.uid)
                          .collection("doctors_liked")
                          .snapshots(),
                      builder: (context, snap) {
                        return snap.data == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 22.0,
                                ),
                                child: ListView.separated(
                                  separatorBuilder: (ctx, i) {
                                    return SizedBox(height: 20);
                                  },
                                  itemCount: snap.data.documents.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int i) {
                                    var doctors = snap.data.documents[i].data;

                                    return Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color:
                                              Colors.lightBlue.withOpacity(0.2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Center(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 80,

                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            doctors[
                                                                "profile_pic"])),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  // child:
                                                  //   Image.network(name),
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 16),
                                                    Text(
                                                      doctors["name"],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 21,
                                                              color:
                                                                  Colors.blue),
                                                    ),
                                                    SizedBox(height: 0),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              126,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            doctors["age"],
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          // Text(
                                                          //   "Indian",
                                                          //   style: GoogleFonts.poppins(
                                                          //       fontSize: 13,
                                                          //       color: Colors.grey),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              );
                      })
            ],
          ),
        ),
      ),
    );
  }
}

class BouncingPhysics {}
