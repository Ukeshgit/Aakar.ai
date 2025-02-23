import 'package:aakar_ai/app/profile/view/widgets/custom_appbar.dart';
import 'package:aakar_ai/app/profile/view/widgets/custom_button.dart';
import 'package:aakar_ai/const/background_color.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:aakar_ai/app/profile/view/pages/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ));
          },
          color: mako,
          text: "Profile",
          icon: Icons.settings,
          textButton: 'Settings',
        ),
        body: Stack(children: [
          GradientBackground(),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        "Sign up to save your\n              art!",
                        style: TextStyle(
                            color: rabbitWhite,
                            fontSize: 30.sp,
                            fontFamily: 'HelveticaMedium'),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CustomButton1(
                          ontap: () {},
                          color2: rabbitWhite,
                          color: edtraaViolet,
                          text: "Create an account",
                          w: double.infinity,
                          h: 50.h),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30.w,
                          ),
                          Text(
                            "Already have an Account? ",
                            style: TextStyle(
                                color: rabbitWhite,
                                fontSize: 16.sp,
                                fontFamily: 'HelveticaMedium'),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: rabbitWhite,
                                  color: iron,
                                  fontSize: 16.sp,
                                  fontFamily: 'HelveticaBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                  ])),
        ]));
  }
}
