import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:lottie/lottie.dart';
import 'package:teen_hacks/check_beat.dart';
import 'dart:ui';
import 'package:teen_hacks/profile.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_charts/src/sparkline/series/spark_area_base.dart';

class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: roomText.text)
      ..serverURL = serverUrl
      ..subject = "Cardio Consultation"
      ..userDisplayName = "Dhanush"
      ..userEmail = "De"
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": "1234",
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": "Dhanush"}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(4278656558),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            // height: MediaQuery.of(context).size.height - 90,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                    top: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello There ",
                                  style: GoogleFonts.poppins(
                                    fontSize: 23.5,
                                    color: Colors.white,
                                  )),
                              Text("Dhanush Vardhan ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 23.5,
                                      height: 1.5,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (c) => Profile(widget.)));
                            //
                             },
                            child: Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg"))))),
                          )
                        ],
                      ),
                      SizedBox(height: 0),
                      ListView.separated(
                        separatorBuilder: (ctx, i) {
                          return SizedBox(height: 20);
                        },
                        itemCount: 1,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
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
                                color: Colors.lightBlue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 70,

                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg")),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                116,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Paul Wilson",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 21,
                                                      color: Colors.white),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              backgroundColor:
                                                                  Color(
                                                                      4278656558),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                height: 220,
                                                                width: double
                                                                    .infinity,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          13.0,
                                                                      right:
                                                                          13),
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        child: SfSparkAreaChart(
                                                                            borderColor: Color(0xFFFF4848),
                                                                            borderWidth: 1,
                                                                            axisLineColor: Colors.transparent,
                                                                            color: Color(
                                                                              0xFFFF4848,
                                                                            ).withOpacity(0.2),
                                                                            //Enable the trackball
                                                                            trackball: SparkChartTrackball(
                                                                              activationMode: SparkChartActivationMode.tap,
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            //Enable marker
                                                                            marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.none),
                                                                            //Enable data label
                                                                            labelDisplayMode: SparkChartLabelDisplayMode.none,
                                                                            data: [
                                                                              33,
                                                                              133,
                                                                              3,
                                                                              33,
                                                                              3,
                                                                              33,
                                                                              3,
                                                                              3,
                                                                              3,
                                                                              3,
                                                                              43,
                                                                              43,
                                                                              44,
                                                                              32,
                                                                              54,
                                                                              56,
                                                                              87,
                                                                              56,
                                                                              33,
                                                                              77,
                                                                              43,
                                                                              45,
                                                                              53,
                                                                              53,
                                                                              55,
                                                                              32,
                                                                              42,
                                                                              45,
                                                                              66,
                                                                              43,
                                                                              54
                                                                            ]),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              20),
                                                                      Text(
                                                                          "Normal Heartbeat",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                23,
                                                                            color:
                                                                                Color(0xFFFF4848),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                        });
                                                  },
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.blue)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .arrow_forward_rounded,
                                                          size: 20,
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () {
                                              _joinMeeting();
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    116,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: Colors.blue,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Call Patient",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                        fontSize: 17),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //     height: 80,
          //     width: double.infinity,
          //     child: Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         Container(
          //           height: 80,
          //           width: double.infinity,
          //           color: Colors.pink,
          //           child: BackdropFilter(
          //             filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          //             child: Container(
          //               height: 80,
          //               width: double.infinity,
          //               color: Colors.pink,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(bottom: .0),
          //           child: Container(
          //             width: MediaQuery.of(context).size.width - 10,
          //             height: 50,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10),
          //                 color: Color(4279980225)),
          //             child: Center(
          //               child: Text(
          //                 "Call Doctor",
          //                 style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     )),
        ],
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
      //   child: Container(
      //     width: MediaQuery.of(context).size.width - 10,
      //     height: 50,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10),
      //         color: Color(4279980225)),
      //     child: Center(
      //       child: Text(
      //         "Call Doctor",
      //         style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 20,
      //             fontWeight: FontWeight.w500),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
