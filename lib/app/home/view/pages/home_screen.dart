import 'dart:convert';
import 'package:aakar_ai/app/home/controller/generating_controller.dart';
import 'package:aakar_ai/app/home/view/pages/advanced_screen.dart';
import 'package:aakar_ai/app/home/view/pages/prompt_screen.dart';
import 'package:aakar_ai/app/profile/view/widgets/custom_appbar.dart';
import 'package:aakar_ai/app/profile/view/widgets/custom_button.dart';
import 'package:aakar_ai/const/background_color.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:aakar_ai/utils/api_endpoint/api_helper.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GeneratingController generatingController = Get.put(GeneratingController());
  final TextEditingController _promptController = TextEditingController();

  String? _base64Image;
  final box = GetStorage();
  @override
  void initState() {
    super.initState();

    // Load saved prompt if it exists
    _promptController.text = box.read('prompt') ?? '';
  }

  void dispose() {
    _promptController.dispose();

    super.dispose();
  }

  Future<void> _generateImage() async {
    generatingController.generate();
    String? image = await ApiService.generateImage(_promptController.text);
    if (image != null) {
      setState(() {
        _base64Image = image;
      });
      String prompt = _promptController.text.trim();
      if (prompt.isNotEmpty) {
        List<String> prompts = box.read<List>('prompts')?.cast<String>() ?? [];
        prompts.add(prompt);
        box.write('prompts', prompts);
        _promptController.clear();
        generatingController.isLoading.value = false;
      }
    } else {
      Get.snackbar(
        "Error",
        "Failed to generate image",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        messageText: const Text(
          "Failed to generate image",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleText: const Text(
          "Error",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
      generatingController.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        ontap: () {},
        color: Colors.black,
        text: "AI Art",
        icon: Icons.star_outline_outlined,
        textButton: 'ART+',
      ),
      body: Stack(
        children: [
          GradientBackground(),
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: deepblue, width: 1),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.w, vertical: 20.h),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Enter Prompt",
                                    style: TextStyle(
                                        color: mako,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22.sp,
                                        fontFamily: 'HelveticaBold')),
                                SizedBox(height: 10.h),
                                TextField(
                                  controller: _promptController,
                                  style: TextStyle(color: rabbitWhite),
                                  onChanged: (value) {
                                    box.write('prompt',
                                        value); // Save input in GetStorage
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Type here in the detailed word what you want to see in your artwork",
                                      hintStyle: TextStyle(
                                          color: mako,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Helvetica')),
                                  maxLines:
                                      null, // Allow the text field to be multi-line if necessary
                                ),
                                Bounce(
                                  onTap: () {
                                    setState(() {
                                      _promptController.text =
                                          "A highly detailed and photorealistic portrait of a young girl with curly blue hair, bright blue eyes, and freckles. She has a gentle and serene expression, set against a softly blurred background. The lighting is warm and natural, emphasizing her features and giving the image a dreamy, artistic quality.";
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 150.w, top: 10.h),
                                      child: CustomButton(
                                        text: "Surprise Me ",
                                        w: 120.w,
                                      )),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      _base64Image != null
                          ? Image.memory(base64Decode(_base64Image!))
                          : Container(),
                      Row(
                        children: [
                          Bounce(
                            onTap: () {
                              Get.to(() => PromptScreen());
                            },
                            child: Container(
                                height: 70.h,
                                width: 170.w,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: deepblue, width: 1),
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(30.r)),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 20.h),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.history_rounded,
                                          color: rabbitWhite,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "Prompt History",
                                          style: TextStyle(
                                              color: rabbitWhite,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15.sp,
                                              fontFamily: 'Helvetica'),
                                        )
                                      ],
                                    ))),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Row(
                            children: [
                              Bounce(
                                onTap: () {},
                                child: Container(
                                    height: 70.h,
                                    width: 170.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: deepblue, width: 1),
                                        color: backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 20.h),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Text(
                                              "Style",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: rabbitWhite,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Helvetica'),
                                            ),
                                            SizedBox(
                                              width: 50.w,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.add,
                                                color: santasGray,
                                                size: 23.sp,
                                              ),
                                            ),
                                          ],
                                        ))),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 180.w,
                          ),
                          Bounce(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdvancedScreen()));
                            },
                            child: Row(
                              children: [
                                Container(
                                    height: 70.h,
                                    width: 170.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: deepblue, width: 1),
                                        color: backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 20.h),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Text(
                                              "Advanced",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: rabbitWhite,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Helvetica'),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                color: santasGray,
                                                size: 23.sp,
                                              ),
                                            ),
                                          ],
                                        ))),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        if (generatingController.isLoading.value) {
                          return Bounce(
                            child: CustomButton1(
                                prefix: Positioned(
                                  left: 15.w,
                                  child: SizedBox(
                                    height: 35.h,
                                    width: 35.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: edtraaViolet,
                                    ),
                                  ),
                                ),
                                ontap: () {},
                                color: deepblue,
                                w: double.infinity,
                                h: 65.h,
                                child: Text(
                                  "CREATING...",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.sp,
                                      fontFamily: "HelveticaMedium"),
                                )),
                          );
                        }
                        return Bounce(
                          child: CustomButton1(
                              ontap: _generateImage,
                              color: deepblue,
                              w: double.infinity,
                              h: 65.h,
                              child: Text(
                                "CREATE",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.sp,
                                    fontFamily: "HelveticaMedium"),
                              )),
                        );
                      })
                    ])),
          ),
        ],
      ),
    );
  }
}
