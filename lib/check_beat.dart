// @dart=2.9

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file/local.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
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
import 'package:slide_popup_dialog/slide_popup_dialog.dart';
import 'package:audioplayers/audioplayers.dart';

class CheckBeat extends StatefulWidget {
  final String uid;
  final LocalFileSystem localFileSystem;

  CheckBeat(this.uid, this.localFileSystem);

  @override
  _CheckBeatState createState() => _CheckBeatState();
}

class _CheckBeatState extends State<CheckBeat> {
  int timeLeft = 10;
//60

  Timer _timer;

  timer() async {
    _start();

    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeLeft == 0) {
        if (mounted) {
          // Dio dio = new Dio();
          // var bytes_data = {"byes": byteData, "username": username};
          // await dio.post("https://flow-live.tech/api/send_recording",
          //     data: FormData.fromMap(bytes_data));

          setState(() {
            timer.cancel();
          });

          _pause();
          _stop();
          Future.delayed(Duration(seconds: 1), () {
            send_data();
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

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(file.path, isLocal: true);
  }

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
  String userType;
  String profile_pic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();
    _init();
    Future.delayed(Duration(seconds: 1), () {
      timer();
    });
  }

  send_data() async {
    Dio dio = new Dio();
    var response = await dio.post("http://flow-live.tech/send_recording",
        data: FormData.fromMap({
          'file': MultipartFile.fromFileSync(_current.path,
              filename: DateTime.now().toString()),
        }));
    print("Classification: " + response.toString());
    uploadToFirebase(response);
  }

  uploadToFirebase(response) async {
    final ref =
        FirebaseStorage.instance.ref().child('${DateTime.now()}recording');
    File recording = new File(_current.path);
    await ref.putFile(recording).onComplete;
    String imgurl = await ref.getDownloadURL();
    print("Image URL: " + imgurl);
    final Map parsed = json.decode(response.toString());
    print(
      parsed["classifications"],
    );
    await Firestore.instance
        .collection("patient")
        .document(widget.uid)
        .collection("recordings")
        .add({
      "result": parsed["classifications"],
      "file_url": imgurl,
      "name": name,
      "age": age,
      "order_Check":DateTime.now(),
      "profile_pic": profile_pic,
      "date": DateFormat("yyyy/MM/dd ").format(DateTime.now()).toString()
    });
    Navigator.pop(context);
  }

  io.File file;
  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    setState(() {
      file = widget.localFileSystem.file(result.path);
    });
    print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
    print(file);
  }

  _pause() async {
    await _recorder.pause();
    setState(() {});
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
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
              timeLeft == 0
                  ? Text("Analyzing...",
                      style: GoogleFonts.poppins(
                          fontSize: 34,
                          color: Color(4284903812),
                          fontWeight: FontWeight.w500))
                  : Row(
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
                          child: Text(timeLeft == 0 ? "" : "sec",
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
                          border: Border.all(color: Colors.blue, width: 2)),
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
