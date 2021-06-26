// @dart=2.9

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:teen_hacks/detail.dart';
import 'package:teen_hacks/home.dart';
import 'package:teen_hacks/wav_header.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';

enum RecordState { stopped, recording }

class CheckBeat extends StatefulWidget {
  final String uid;

  CheckBeat(this.uid);

  @override
  _CheckBeatState createState() => _CheckBeatState();
}

class _CheckBeatState extends State<CheckBeat> {
  int timeLeft = 60;
//60

  Timer _timer;

  timer() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeLeft == 0) {
        if (mounted) {
          // Dio dio = new Dio();
          // var bytes_data = {"byes": byteData, "username": username};
          // await dio.post("https://flow-live.tech/api/send_recording",
          //     data: FormData.fromMap(bytes_data));

          setState(() {
            timer.cancel();
            // Navigator.pop(context);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            timeLeft--;
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hold on ",
                            style: GoogleFonts.poppins(
                              fontSize: 27,
                              fontWeight: FontWeight.w500,
                          color: Color(4284903812),
                            )),
                        Text("We are analyzing . . . . ",
                            style: GoogleFonts.poppins(
                                fontSize: 27,
                                height: 1.2,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 260,
                      width: 260,
                      child: Lottie.asset("assets/beat.json",
                          frameRate: FrameRate.max),
                      decoration: BoxDecoration()),
                ),
              ),
              SizedBox(height: 60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      // time_left.toString()

                      timeLeft.toString(),
                      style: TextStyle(
                          fontSize: 60,
                          color: Color(4284903812),
                          fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 5),
                    child: Text("sec",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(4291874251),
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (c) => Home(widget.uid)),
                      (route) => false);
                },
                child: Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue,width: 2)),
                      child: Icon(
                        Icons.close_rounded,
                        size: 34,
                        color: Color(4284903812),
                      )),
                ),
              )
            ],
          )),
    );
  }
}
