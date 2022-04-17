import 'dart:async';

import 'package:bill_seperator/views/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF6FB3F5),
      body: Stack(
        children: [
          Positioned(
            top: size.height * 0.1,
            left: 20,
            right: 20,
            // bottom: 50,
            child: Image.asset("asset/images/f.png"),
          ),
          Positioned(
            top: size.height * 0.53,
            left: size.width * 0.3,
            //right: 50,
            // bottom: 50,
            child: const Text(
              "Bill Splitter",
              style: TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
                fontFamily: "Lobster",
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.6,
            left: 20,
            right: 20,
            bottom: size.height * 0.2,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFFEFF),
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  "Easy to Share bills with your friends and anyone.",
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "VarelaRound",
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height - 100,
            left: size.width * 0.45,
            child: const CircularProgressIndicator(
              color: Colors.pink,
            ),
          )
        ],
      ),
    );
  }

  void setTimer() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }
}
