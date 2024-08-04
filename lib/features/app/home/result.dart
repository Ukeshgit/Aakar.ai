import 'package:aakar_ai/features/app/global/theme/colors.dart';
import 'package:aakar_ai/features/user/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Result extends StatelessWidget {
  const Result({super.key});

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
              "Result",
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
          SingleChildScrollView(
            child: Container(
                height: 600.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                    color: mako, borderRadius: BorderRadius.circular(15.r)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/ai_image.jpg",
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: ExpansionTile(
                          collapsedIconColor: rabbitWhite,
                          minTileHeight: 55,
                          title: Text(
                            "Prompt",
                            style:
                                TextStyle(color: rabbitWhite, fontSize: 18.sp),
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                'A highly detailed and photorealistic portrait of a young girl with curly blue hair, bright blue eyes, and freckles. She has a gentle and serene expression, set against a softly blurred background. The lighting is warm and natural, emphasizing her features and giving the image a dreamy, artistic quality.',
                                style: TextStyle(
                                    color: rabbitWhite, fontSize: 16.sp),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          )
        ]));
  }
}
