import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({super.key, required this.imagelink});
  final String imagelink;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 60.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.sp)),
      child: Center(
        child: SvgPicture.asset(
          imagelink,
          height: 45.h,
          width: 45.w,
        ),
      ),
    );
  }
}
