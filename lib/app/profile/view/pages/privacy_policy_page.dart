import 'package:aakar_ai/app/profile/view/widgets/custom_button.dart';
import 'package:aakar_ai/app/profile/view/widgets/generate_user_id.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:aakar_ai/const/privacy_policy.dart';
import 'package:aakar_ai/const/terms_and_services.dart';
import 'package:aakar_ai/utils/api_endpoint/open_email.dart';
import 'package:bounce/bounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: deepblue,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: rabbitWhite,
            ),
          ),
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.only(right: 20.h),
            child: Text(
              "Privacy Policy",
              style: TextStyle(
                color: rabbitWhite,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        body: Stack(children: [
          Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D0D4D), // dark blue color towards the bottom
                mako // black color at the top
              ],
            ),
          )),
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r)),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            privacyPolicy,
                            style:
                                TextStyle(color: rabbitWhite, fontSize: 16.sp),
                          )
                        ]),
                  )))
        ]));
  }
}
