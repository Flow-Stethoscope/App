// @dart=2.9

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:fade/fade.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:teen_hacks/bluetooth_connec.dart';
import 'package:teen_hacks/check_beat.dart';
import 'package:teen_hacks/device_list.dart';
import 'package:teen_hacks/doctor_home.dart';
import 'dart:ui';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:teen_hacks/profile.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:file/local.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  String uid;
  Home(this.uid);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            age = value["age"];
            profile_pic = value["profile_pic"];

            print("name");
            print("profile_pic");
          });
        });
      });
    });
  }

  String name;
  String age;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();
  }

  String userType;
  String profile_pic;
  @override
  Widget build(BuildContext context) {
    var _selectedTab;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(4280118015),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hello There ,",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Color(4294507261),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 0),
                          Text(
                            name ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 26,
                                color: Color(4294507261),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          userType == "doctor"
                              ? showBarModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (cx) {
                                    return Container(
                                      height:200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                    width: 120,
                                                    height: 140,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                profile_pic ==
                                                                        null
                                                                    ? ""
                                                                    : profile_pic)))),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 214,
                                                      child: Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child: Text(
                                                              name == null
                                                                  ? ""
                                                                  : name,
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color:
                                                                      Colors.blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "$age years old",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Profile(widget.uid)));
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Container(
                                width: 59,
                                height: 59,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(profile_pic == null
                                          ? ""
                                          : profile_pic),
                                    )))),
                      )
                    ]),
                SizedBox(height: 10),
                // Row(
                //   children: [
                //     Align(
                //       alignment: Alignment.centerLeft,
                //       child: SingleChildScrollView(
                //           scrollDirection: Axis.horizontal,
                //           child:
                //     ),
                //   ],
                //)
                userType == "doctor"
                    ? Container()
                    : Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showBarModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15),
                                            child: Text(
                                              "Look For Doctors To Add",
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15),
                                            child: StreamBuilder(
                                                stream: Firestore.instance
                                                    .collection("doctor")
                                                    .snapshots(),
                                                builder: (context, snap) {
                                                  return snap.data == null
                                                      ? Container()
                                                      : ListView.separated(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          separatorBuilder:
                                                              (ctx, i) {
                                                            return SizedBox(
                                                                height: 20);
                                                          },
                                                          itemCount: snap.data
                                                              .documents.length,
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int i) {
                                                            var doctors = snap
                                                                .data
                                                                .documents[i]
                                                                .data;
                                                            return Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 100,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // boxShadow: [
                                                                  //   BoxShadow(
                                                                  //     color: Colors.black.withOpacity(0.1),
                                                                  //     spreadRadius: 0.3,
                                                                  //     blurRadius: 10,
                                                                  //     offset: Offset(0, 3), // changes position of shadow
                                                                  //   ),
                                                                  // ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  color: Colors
                                                                      .lightBlue
                                                                      .withOpacity(
                                                                          0.2),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right: 8),
                                                                  child: Center(
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              80,

                                                                          height:
                                                                              80,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.2),
                                                                            image:
                                                                                DecorationImage(fit: BoxFit.cover, image: NetworkImage(doctors["profile_pic"])),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          // child:
                                                                          //   Image.network(name),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                10),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(height: 16),
                                                                            Text(
                                                                              doctors["name"],
                                                                              style: TextStyle(fontSize: 21, color: Colors.blue),
                                                                            ),
                                                                            SizedBox(height: 5),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                Firestore.instance.collection("patient").document(widget.uid).collection("doctors_liked").add({
                                                                                  "age": doctors["age"],
                                                                                  "doctor_uid": snap.data.documents[i].documentID,
                                                                                  "profile_pic": doctors["profile_pic"],
                                                                                  "name": doctors["name"]
                                                                                });
                                                                                Navigator.pop(context);
                                                                                //                                                                                                           var dio=Dio();
                                                                                //                                                                                                           var send_messgae={"url":user["recordings"][index]["url"]}
                                                                                //  await dio.post("https://flow-live.tech/user/send_recording",
                                                                                //               data: FormData.fromMap(send_messgae));
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      Future.delayed(Duration(seconds: 3), () {
                                                                                        Navigator.of(context).pop(true);
                                                                                      });
                                                                                      return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: Colors.grey[900], child: Container(width: 200, height: 130, child: Lottie.asset("assets/tick.json", repeat: false)));
                                                                                    });
                                                                              },
                                                                              child: Container(
                                                                                  width: MediaQuery.of(context).size.width - 136,
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      "Add",
                                                                                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 17),
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ));
                                                          },
                                                        );
                                                }),
                                          )
                                        ]);
                                  });
                            },
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                child: Icon(Icons.add, color: Colors.white)),
                          ),
                          SizedBox(width: 0),
                          Container(
                            width: MediaQuery.of(context).size.width - 85,
                            height: 80,
                            child: userType == null
                                ? Container()
                                : StreamBuilder(
                                    stream: Firestore.instance
                                        .collection("patient")
                                        .document(widget.uid)
                                        .collection("doctors_liked")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      return snapshot.data == null
                                          ? Container()
                                          : ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot
                                                  .data.documents.length,
                                              itemBuilder: (ctx, i) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white
                                                            .withOpacity(0.3),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                snapshot
                                                                        .data
                                                                        .documents[
                                                                            i]
                                                                        .data[
                                                                    "profile_pic"]))),
                                                  ),
                                                );
                                              });
                                    }),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: userType == "doctor"
                  ? MediaQuery.of(context).size.height - 180
                  : MediaQuery.of(context).size.height - 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(4294967295),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 475,
                    child: userType == "doctor"
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection(userType)
                                    .document(widget.uid)
                                    .collection("recordings")
                                    .orderBy("order_Check", descending: true)
                                    .snapshots(),
                                builder: (ctx, snap) {
                                  return snap.data == null
                                      ? Container()
                                      : ListView.separated(
                                          itemCount: snap.data.documents.length,
                                          shrinkWrap: true,
                                          separatorBuilder: (ctx, i) {
                                            return SizedBox(height: 10);
                                          },
                                          itemBuilder: (context, i) {
                                            var data =
                                                snap.data.documents[i].data;

                                            return Container(
                                                width: double.infinity,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.black.withOpacity(0.1),
                                                  //     spreadRadius: 0.7,
                                                  //     blurRadius: 20,
                                                  //     offset: Offset(
                                                  //         0, 3), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                  color: Colors.lightBlue
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                  child: Center(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 75,

                                                          height: 75,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    data[
                                                                        "profile_pic"])),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          // child:
                                                          //   Image.network(name),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                                height: 16),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  116,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 180,
                                                                    child:
                                                                        Expanded(
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child:
                                                                            Text(
                                                                          data[
                                                                              "name_patient"],
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: 21,
                                                                              color: Colors.blue),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      AudioPlayer
                                                                          audioPlayer =
                                                                          AudioPlayer();
                                                                      await audioPlayer.play(
                                                                          data[
                                                                              "file_url"],
                                                                          isLocal:
                                                                              true);
                                                                    },
                                                                    child: Container(
                                                                        alignment: Alignment.center,
                                                                        width: 30,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.blue)),
                                                                        child: Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.play_circle,
                                                                            size:
                                                                                25,
                                                                            color:
                                                                                Colors.blue,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    launch(
                                                                        "tel://${data["phone"]}");
                                                                  },
                                                                  child: Container(
                                                                      width: 160,
                                                                      height: 29,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6),
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                      child: Center(
                                                                        child:
                                                                            Text(
                                                                          "Call Patient",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.white,
                                                                              fontSize: 13),
                                                                        ),
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  width: 17,
                                                                ),
                                                                Text(
                                                                  data[
                                                                      "result"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: data["result"] ==
                                                                            "Normal"
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          });
                                }),
                          )
                        : userType == null
                            ? Container()
                            : StreamBuilder(
                                stream: Firestore.instance
                                    .collection(userType)
                                    .document(widget.uid)
                                    .collection("recordings")
                                    .orderBy("order_Check", descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  return snapshot.data == null
                                      ? Container()
                                      : ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data.documents.length,
                                          itemBuilder: (ctx, i) {
                                            print(snapshot.data.documents[i]
                                                .data["name"]);
                                            print("dwe");
                                            var data =
                                                snapshot.data.documents[i].data;
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  bottom: 10),
                                              child: Container(
                                                  width: double.infinity,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    // boxShadow: [
                                                    //   BoxShadow(
                                                    //     color: Colors.black.withOpacity(0.1),
                                                    //     spreadRadius: 0.7,
                                                    //     blurRadius: 20,
                                                    //     offset: Offset(
                                                    //         0, 3), // changes position of shadow
                                                    //   ),
                                                    // ],
                                                    color: Colors.lightBlue
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8),
                                                    child: Center(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 70,

                                                            height: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.6),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/wave.png")),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            // child:
                                                            //   Image.network(name),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                  height: 16),
                                                              Text(
                                                                "${data["result"]} Heartbeat",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        21,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                              SizedBox(
                                                                  height: 8),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    119,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      data[
                                                                          "date"],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // showSlideDialog(
                                                                        //     barrierDismissible:
                                                                        //         true,
                                                                        //     context: context,
                                                                        //     child:
                                                                        //         ListView.separated(
                                                                        //             itemBuilder:
                                                                        //                 (ctx, i) {
                                                                        //               return Container();
                                                                        //             },
                                                                        //             separatorBuilder:
                                                                        //                 (ctx, i) =>
                                                                        //                     SizedBox(
                                                                        //                         height:
                                                                        //                             10),
                                                                        //             itemCount: 3));
                                                                        showBarModalBottomSheet(
                                                                            backgroundColor: Colors
                                                                                .white,
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Container(
                                                                                color: Colors.white,
                                                                                child: SingleChildScrollView(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Text(
                                                                                          "Share it with your doctor",
                                                                                          style: TextStyle(fontSize: 23, color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(
                                                                                            bottom: 22.0,
                                                                                          ),
                                                                                          child: userType == null
                                                                                              ? Container()
                                                                                              : Column(
                                                                                                  children: [
                                                                                                    StreamBuilder(
                                                                                                        stream: Firestore.instance.collection("patient").document(widget.uid).collection("doctors_liked").snapshots(),
                                                                                                        builder: (context, snap) {
                                                                                                          return snap.data == null
                                                                                                              ? Container()
                                                                                                              : ListView.separated(
                                                                                                                  physics: NeverScrollableScrollPhysics(),
                                                                                                                  separatorBuilder: (ctx, i) {
                                                                                                                    return SizedBox(height: 20);
                                                                                                                  },
                                                                                                                  itemCount: snap.data.documents.length,
                                                                                                                  shrinkWrap: true,
                                                                                                                  itemBuilder: (BuildContext context, int i) {
                                                                                                                    var doctors = snap.data.documents[i].data;
                                                                                                                    return Container(
                                                                                                                        width: double.infinity,
                                                                                                                        height: 100,
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          // boxShadow: [
                                                                                                                          //   BoxShadow(
                                                                                                                          //     color: Colors.black.withOpacity(0.1),
                                                                                                                          //     spreadRadius: 0.3,
                                                                                                                          //     blurRadius: 10,
                                                                                                                          //     offset: Offset(0, 3), // changes position of shadow
                                                                                                                          //   ),
                                                                                                                          // ],
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
                                                                                                                                    image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(doctors["profile_pic"])),
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
                                                                                                                                      doctors["name"],
                                                                                                                                      style: TextStyle(fontSize: 21, color: Colors.blue),
                                                                                                                                    ),
                                                                                                                                    SizedBox(height: 5),
                                                                                                                                    GestureDetector(
                                                                                                                                      onTap: () async {
                                                                                                                                        Firestore.instance.collection("doctor").document(doctors["doctor_uid"]).collection("recordings").add({
                                                                                                                                          "age": age,
                                                                                                                                          "date": data["date"],
                                                                                                                                          "name_patient": name,
                                                                                                                                          "phone": data["phone"],
                                                                                                                                          "result": data["result"],
                                                                                                                                          "profile_pic": profile_pic,
                                                                                                                                          "order_Check": DateTime.now(),
                                                                                                                                          "file_url": data["file_url"],
                                                                                                                                        });
                                                                                                                                        Navigator.pop(context);
                                                                                                                                        //                                                                                                           var dio=Dio();
                                                                                                                                        //                                                                                                           var send_messgae={"url":user["recordings"][index]["url"]}
                                                                                                                                        //  await dio.post("https://flow-live.tech/user/send_recording",
                                                                                                                                        //               data: FormData.fromMap(send_messgae));
                                                                                                                                        showDialog(
                                                                                                                                            context: context,
                                                                                                                                            builder: (context) {
                                                                                                                                              Future.delayed(Duration(seconds: 3), () {
                                                                                                                                                Navigator.of(context).pop(true);
                                                                                                                                              });
                                                                                                                                              return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: Colors.grey[900], child: Container(width: 200, height: 130, child: Lottie.asset("assets/tick.json", repeat: false)));
                                                                                                                                            });
                                                                                                                                      },
                                                                                                                                      child: Container(
                                                                                                                                          width: MediaQuery.of(context).size.width - 136,
                                                                                                                                          height: 30,
                                                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])),
                                                                                                                                          child: Center(
                                                                                                                                            child: Text(
                                                                                                                                              "Send",
                                                                                                                                              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 17),
                                                                                                                                            ),
                                                                                                                                          )),
                                                                                                                                    ),
                                                                                                                                  ],
                                                                                                                                )
                                                                                                                              ],
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ));
                                                                                                                  },
                                                                                                                );
                                                                                                        }),
                                                                                                    SizedBox(height: 30),
                                                                                                  ],
                                                                                                ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .share,
                                                                        color: Colors
                                                                            .grey,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            );
                                          });
                                }),
                  ),
                ],
              ),
            ),
          ),
          userType == "doctor"
              ? Container()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>
                                  CheckBeat(widget.uid, _localPath)));
                    },
                    child: new ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      child: new BackdropFilter(
                        filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: new Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100)),
                          ),
                          width: double.infinity,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Colors.blue,
                                  Colors.lightBlueAccent
                                ])),
                            child: Center(
                              child: Text(
                                "Analayse Heartbeat",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ]),
      ),
    );
  }

  LocalFileSystem _localPath;
}
