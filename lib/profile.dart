// @dart=2.9


import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  String uid;
  Profile(this.uid);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://t4.ftcdn.net/jpg/02/14/74/61/360_F_214746128_31JkeaP6rU0NzzzdFC4khGkmqc8noe6h.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(
                                (15),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Container(
                        width: 75,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.indigo,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.white.withOpacity(0.5),
                          //     spreadRadius: 10,
                          //     blurRadius: 20,
                          //     offset:
                          //         Offset(0, 3), // changes position of shadow
                          //   ),
                          // ],
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Dhanush",
                  // "Dhanush",
                  style: GoogleFonts.poppins(
                      fontSize: 27,
                      height: 1.5,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 0),
              Text(
                "18 years",
                style: GoogleFonts.poppins(fontSize: 17, color: Colors.grey),
              ),
              SizedBox(height: 30),
              Text(
                "Your Doctors",
                style: GoogleFonts.poppins(
                    // height:0,
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 22.0,
                ),
                child: ListView.separated(
                  separatorBuilder: (ctx, i) {
                    return SizedBox(height: 20);
                  },
                  itemCount:2,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.lightBlue.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,

                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://cdn8.dissolve.com/p/D9_39_166/D9_39_166_1200.jpg")),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // child:
                                  //   Image.network(name),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16),
                                    Text(
                                      "Steve Smith",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21,
                                          color: Colors.blue),
                                    ),
                                    SizedBox(height: 0),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          126,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "29 years ",
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.grey),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BouncingPhysics {}
