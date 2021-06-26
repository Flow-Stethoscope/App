import 'package:flutter/material.dart';

class WaitForResult extends StatefulWidget {
  const WaitForResult({Key? key}) : super(key: key);

  @override
  _WaitForResultState createState() => _WaitForResultState();
}

class _WaitForResultState extends State<WaitForResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(4278656558),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 260,
            width: 260,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.4)),
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
