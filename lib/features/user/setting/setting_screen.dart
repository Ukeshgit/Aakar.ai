import 'package:aakar_ai/features/app/global/theme/background_color.dart';
import 'package:aakar_ai/features/app/global/theme/colors.dart';
import 'package:aakar_ai/features/user/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      settingInfo(Icons.person_add_alt_rounded, "Invite"),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.notification_important_outlined,
                          "Notifications"),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(
                          Icons.my_library_books_outlined, "Terms of Services"),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.privacy_tip, "Privacy Policy"),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.developer_board, "About Us"),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.person, "User ID"),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.support, "Support"),
                      Divider(
                        thickness: 0.1,
                        color: santasGray,
                      ),
                      settingInfo(Icons.login, "Logout"),
                    ]),
              ))
        ]));
  }

  Widget settingInfo(IconData icon, String text) {
    return Container(
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
          Icon(
            Icons.keyboard_arrow_right_outlined,
            color: mako,
            size: 30.sp,
          )
        ],
      ),
    );
  }
}
