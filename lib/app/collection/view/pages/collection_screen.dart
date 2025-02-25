import 'package:aakar_ai/app/home/controller/home_controller.dart';
import 'package:aakar_ai/app/home/controller/textfeild_controller.dart';
import 'package:aakar_ai/app/home/view/pages/home_screen.dart';
import 'package:aakar_ai/app/profile/view/widgets/custom_appbar.dart';
import 'package:aakar_ai/const/background_color.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  int currentIndex1 = 0;
  int currentIndex2 = 0;

  List<Map<String, String>> imageList = [
    {"id": "1", "image_path": "assets/images/carousel1.jpg"},
    {"id": "2", "image_path": "assets/images/carousel2.png"},
    {"id": "3", "image_path": "assets/images/carousel3.jpg"},
  ];

  List<Map<String, String>> imageList2 = [
    {"id": "1", "image_path": "assets/images/carousel4.jpg"},
    {"id": "2", "image_path": "assets/images/carousel5.jpg"},
    {"id": "3", "image_path": "assets/images/carousel6.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.find<HomeController>().setIndex(0);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          suffix: Container(),
          ontap: () {},
          color: Colors.black,
          text: "AI STORE",
          icon: Icons.star_outline_outlined,
          textButton: 'STORE+',
        ),
        body: Stack(
          children: [
            GradientBackground(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Avatar",
                    style: TextStyle(
                      color: rabbitWhite,
                      fontSize: 20.sp,
                      fontFamily: "Helvetica",
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 180.h,
                    child: CarouselView(
                      itemSnapping: true,
                      enableSplash: true,
                      scrollDirection: Axis.horizontal,
                      itemExtent: 222,
                      children: imageList.map((item) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            item['image_path']!,
                            height: 168.h,
                            width: 128.w,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 180.h,
                    child: CarouselView(
                      itemSnapping: true,
                      enableSplash: true,
                      scrollDirection: Axis.horizontal,
                      itemExtent: 200.w,
                      children: imageList2.map((item) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            item['image_path']!,
                            height: 168.h,
                            width: 128.w,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
