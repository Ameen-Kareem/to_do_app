import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_app/view/task_screen/task_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(
      Duration(
        seconds: 3,
      ),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TaskScreen(),
          )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash\nScreen",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}
