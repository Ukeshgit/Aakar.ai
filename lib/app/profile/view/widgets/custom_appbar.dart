import 'package:aakar_ai/const/colors.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasLeading;
  final String text;
  final Widget? suffix;
  final Color color;
  final String textButton;
  final IconData icon;
  final VoidCallback ontap; // Ensure `ontap` is required

  CustomAppBar(
      {Key? key,
      this.hasLeading = true,
      required this.color,
      required this.textButton,
      required this.text,
      required this.ontap,
      required this.icon,
      this.suffix})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(62.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.black,
      actions: [
        suffix ??
            Bounce(
              onTap: ontap,
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                height: 32.h,
                width: 93.w,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Icon(
                        icon,
                        color: rabbitWhite,
                        size: 14.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      textButton,
                      style: TextStyle(
                        color: rabbitWhite,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
      leading: hasLeading
          ? Image.asset(
              "assets/images/logo.png",
              height: 80.h,
              width: 80.h,
            )
          : null,
      title: Text(
        text,
        style: TextStyle(
          color: rabbitWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
