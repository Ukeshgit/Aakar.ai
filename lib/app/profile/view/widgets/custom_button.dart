import 'package:aakar_ai/const/colors.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double w;
  const CustomButton({
    super.key,
    required this.text,
    required this.w,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.blueAccent, width: 2)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w400,
              fontFamily: "HelveticaMedium"),
        ),
      ),
    );
  }
}

class CustomButton1 extends StatelessWidget {
  final Widget child;
  final Widget? prefix;
  final double w;
  final double h;
  final Color color;

  final Function() ontap;
  const CustomButton1(
      {super.key,
      required this.child,
      this.prefix,
      required this.w,
      required this.h,
      required this.color,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: ontap,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(35.r),
        ),
        child: Stack(
          alignment: Alignment.center, // Ensures child remains centered
          children: [
            prefix ?? Container(),

            Center(child: child), // Ensures child is always in the center
          ],
        ),
      ),
    );
  }
}
