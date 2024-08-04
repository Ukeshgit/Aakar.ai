import 'dart:async';
import 'package:aakar_ai/features/app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aakar_ai/features/app/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    const duration = Duration(seconds: 5);
    final increment = 0.01;
    final totalIncrements = 100;
    final updateInterval = duration.inMilliseconds ~/ totalIncrements;

    _timer = Timer.periodic(Duration(milliseconds: updateInterval), (timer) {
      setState(() {
        _progress += increment;
      });

      if (_progress >= 1.0) {
        timer.cancel();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 250.h,
            ),
            Center(child: Image.asset("assets/images/logo.png")),
            Spacer(),
            Center(
                child: Image.asset(
              "assets/images/text.png",
              height: 90.h,
              width: 120.w,
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8.r),
                backgroundColor: const Color.fromARGB(255, 59, 89, 103),
                color: Colors.blue,
                value: _progress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
