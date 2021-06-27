import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teen_hacks/doctor_home.dart';
import 'package:teen_hacks/login.dart';

import 'home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
 textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
         ),
      ),
      home: Login(),
    );
  }
}
