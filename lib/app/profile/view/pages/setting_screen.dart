import 'package:aakar_ai/app/profile/view/pages/about_us._page.dart';
import 'package:aakar_ai/app/profile/view/pages/notification_screen.dart';
import 'package:aakar_ai/app/profile/view/pages/privacy_policy_page.dart';
import 'package:aakar_ai/app/profile/view/pages/tems_of_services_page.dart';
import 'package:aakar_ai/app/profile/view/widgets/custom_button.dart';
import 'package:aakar_ai/app/profile/view/widgets/generate_user_id.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:aakar_ai/utils/api_endpoint/open_email.dart';
import 'package:bounce/bounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
              "Settings",
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
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // settingInfo(
                      //     Icons.person_add_alt_rounded, "Invite", () {}),
                      // Divider(
                      //   thickness: 0.1,
                      //   color: santasGray,
                      // ),
                      settingInfo(Icons.notification_important_outlined,
                          "Notifications", () {
                        Get.to(() => NotificationScreen());
                      }),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(
                        Icons.my_library_books_outlined,
                        "Terms of Services",
                        () {
                          Get.to(() => TemsOfServicesPage());
                        },
                      ),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.privacy_tip, "Privacy Policy", () {
                        Get.to(() => PrivacyPolicyPage());
                      }),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.developer_board, "About Us", () {
                        Get.to(() => AboutUsPage());
                      }),
                      Divider(
                        thickness: 0.13,
                        color: santasGray,
                      ),
                      settingInfo(
                          suffix: Row(
                            children: [
                              Text(
                                generateUserId(),
                                style: TextStyle(color: mako, fontSize: 16.sp),
                              ),
                              SizedBox(
                                width: 6.sp,
                              ),
                              Icon(
                                Icons.copy_all_outlined,
                                color: mako,
                                size: 24.sp,
                              )
                            ],
                          ),
                          Icons.person,
                          "User ID", () {
                        Clipboard.setData(
                            ClipboardData(text: generateUserId()));
                        Get.snackbar(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          "User id Copied",
                          "",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.blueAccent,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(10),
                          borderRadius: 8,
                          messageText: const Text(
                            "User id Copied",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          titleText: const Text(
                            "Success",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.support, "Support", () {
                        openEmail();
                      },
                          suffix: Text(
                            'support@aakar.ai',
                            style: TextStyle(color: mako, fontSize: 16.sp),
                          )),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.login, "Logout", () {
                        // FirebaseAuth.instance.signOut();
                        showLogoutPopup(context);
                      }),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      Spacer(),
                      Center(
                        child: Text(
                          '*For Major Project @2081*',
                          style: TextStyle(color: mako, fontSize: 16.sp),
                        ),
                      ),
                    ]),
              ))
        ]));
  }

  void showLogoutPopup(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: mako,
            insetPadding: EdgeInsets.symmetric(horizontal: 16.h),
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout?",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                // some spacing
                SizedBox(height: 12.h),

                // middle text
                Text(
                  "Are you sure want to logout?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Color(0XFFffffff)),
                ),

                // some spacing
                SizedBox(height: 22.h),

                // cancel button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton1(
                        ontap: () {
                          Navigator.pop(context);
                        },
                        w: 100.w,
                        color: Color(0xffBF796F),
                        h: 35.h,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                    Spacer(),
                    CustomButton1(
                      ontap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pop(context);
                      },
                      w: 100.w,
                      color: Color(0xffBF796F),
                      h: 35.h,
                      child: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget settingInfo(IconData icon, String text, Function() ontap,
      {Widget? suffix}) {
    return Bounce(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: rabbitWhite,
              size: 18.sp,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              text,
              style: TextStyle(
                  color: rabbitWhite,
                  fontSize: 18.sp,
                  fontFamily: 'HelveticaBold'),
            ),
            Spacer(),
            suffix ??
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: mako,
                  size: 30.sp,
                )
          ],
        ),
      ),
    );
  }
}
