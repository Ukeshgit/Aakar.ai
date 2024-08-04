import 'package:aakar_ai/features/app/global/theme/colors.dart';
import 'package:aakar_ai/features/user/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvancedScreen extends StatelessWidget {
  const AdvancedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: deepblue,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close_rounded,
              color: rabbitWhite,
            ),
          ),
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.only(right: 20.h),
            child: Text(
              "Advanced Settings",
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
              child: SingleChildScrollView(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add image",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: 'Helvetica',
                                color: rabbitWhite),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomButton1(
                              text: "Upload Image",
                              w: double.infinity,
                              h: 60.h,
                              color: mako,
                              color2: rabbitWhite),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Negative Prompt",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: 'Helvetica',
                                color: rabbitWhite),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: mako,
                            ),
                            child: TextField(
                              style: TextStyle(color: rabbitWhite),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Dont Include......",
                                  contentPadding:
                                      EdgeInsets.only(left: 80.w, top: 10.h),
                                  hintStyle: TextStyle(
                                      color: rabbitWhite,
                                      fontFamily: "HelveticaBold",
                                      fontSize: 18.sp)),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Aspect Ratio",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: 'Helvetica',
                                color: rabbitWhite),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(mako)),
                                    onPressed: () {},
                                    child: Text(
                                      "1:1",
                                      style: TextStyle(color: rabbitWhite),
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(mako)),
                                    onPressed: () {},
                                    child: Text(
                                      "4:3",
                                      style: TextStyle(color: rabbitWhite),
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(mako)),
                                    onPressed: () {},
                                    child: Text(
                                      "3:4",
                                      style: TextStyle(color: rabbitWhite),
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(mako)),
                                    onPressed: () {},
                                    child: Text(
                                      "2:3",
                                      style: TextStyle(color: rabbitWhite),
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(mako)),
                                    onPressed: () {},
                                    child: Text(
                                      "3:2",
                                      style: TextStyle(color: rabbitWhite),
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(mako)),
                                    onPressed: () {},
                                    child: Text(
                                      "9:16",
                                      style: TextStyle(color: rabbitWhite),
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(mako)),
                                    onPressed: () {},
                                    child: Text(
                                      "16:9",
                                      style: TextStyle(color: rabbitWhite),
                                    )),
                              ],
                            ),
                          )
                        ])),
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
