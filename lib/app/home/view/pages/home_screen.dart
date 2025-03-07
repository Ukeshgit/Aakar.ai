import 'dart:convert';
import 'dart:math';
import 'package:aakar_ai/app/home/controller/generating_controller.dart';
import 'package:aakar_ai/app/home/controller/textfeild_controller.dart';
import 'package:aakar_ai/app/home/view/pages/advanced_screen.dart';
import 'package:aakar_ai/app/home/view/pages/home.dart';
import 'package:aakar_ai/app/home/view/pages/prompt_screen.dart';
import 'package:aakar_ai/app/home/view/pages/result_screen.dart';
import 'package:aakar_ai/app/home/view/pages/style_page.dart';
import 'package:aakar_ai/app/profile/view/widgets/custom_appbar.dart';
import 'package:aakar_ai/app/profile/view/widgets/custom_button.dart';
import 'package:aakar_ai/const/background_color.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:aakar_ai/utils/api_endpoint/api_helper.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
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

  final TextFieldController controller = Get.put(TextFieldController());

  String? _base64Image;
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _promptController.dispose();

    super.dispose();
  }

  List<String> prompts = [
    "A majestic dragon with shimmering emerald scales soaring over a medieval castle, with the sun setting behind the mountains.",
    "A futuristic astronaut exploring an alien planet with bioluminescent plants and a glowing blue river under a starry sky.",
    "A cozy cabin in the middle of a snowy forest, with warm light glowing from the windows and smoke rising from the chimney.",
    "A cybernetic samurai standing in the rain under neon lights, gripping a high-tech katana with a determined expression.",
    "A giant octopus wrapping its tentacles around a sunken pirate ship in the deep ocean, with beams of light filtering through the water.",
    "An enchanted library with floating books, glowing runes on the walls, and a wise old owl perched on a wooden stand.",
    "A post-apocalyptic city overgrown with vines and trees, where nature has reclaimed the ruins of skyscrapers and highways.",
    "A mystical sorceress casting a powerful spell in the middle of a storm, her robes flowing as lightning crackles around her.",
    "A robotic dog with glowing eyes standing in a futuristic city, scanning its surroundings as flying cars zoom overhead.",
    "A Viking warrior on a stormy sea, standing on a wooden ship with a massive axe, ready for battle as lightning flashes in the sky."
  ];

  void _setRandomPrompt() {
    final random = Random();
    String randomPrompt = prompts[random.nextInt(prompts.length)];

    setState(() {
      _promptController.text = randomPrompt;
      controller.isDataPresent.value = true;
      box.write('prompt', randomPrompt);
    });
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
      }

      generatingController.isLoading.value = false;
      Get.to(() => Result(base64Image: _base64Image, prompt: prompt));
    } else {
      generatingController.isLoading.value = false;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        suffix: Container(),
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
                                    controller.isDataPresent.value =
                                        value.isNotEmpty;
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
                                Obx(() {
                                  return controller.isDataPresent.value
                                      ? Container()
                                      : Bounce(
                                          onTap: () {
                                            _setRandomPrompt();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 150.w, top: 10.h),
                                              child: CustomButton(
                                                text: "Surprise Me ",
                                                w: 120.w,
                                              )),
                                        );
                                }),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          // Row(
                          //   children: [
                          //     Bounce(
                          //       onTap: () {
                          //         Get.to(() => StylePage());
                          //       },
                          //       child: Container(
                          //           height: 70.h,
                          //           width: 170.w,
                          //           decoration: BoxDecoration(
                          //               border: Border.all(
                          //                   color: deepblue, width: 1),
                          //               color: backgroundColor,
                          //               borderRadius:
                          //                   BorderRadius.circular(30.r)),
                          //           child: Padding(
                          //               padding: EdgeInsets.symmetric(
                          //                   horizontal: 15.w, vertical: 20.h),
                          //               child: Row(
                          //                 children: [
                          //                   SizedBox(
                          //                     width: 20.w,
                          //                   ),
                          //                   Text(
                          //                     "Style",
                          //                     style: TextStyle(
                          //                         fontSize: 15.sp,
                          //                         color: rabbitWhite,
                          //                         fontWeight: FontWeight.w300,
                          //                         fontFamily: 'Helvetica'),
                          //                   ),
                          //                   SizedBox(
                          //                     width: 50.w,
                          //                   ),
                          //                   Align(
                          //                     alignment: Alignment.centerRight,
                          //                     child: Icon(
                          //                       Icons.add,
                          //                       color: santasGray,
                          //                       size: 23.sp,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ))),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 180.w,
                      //     ),
                      //     Bounce(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     const AdvancedScreen()));
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Container(
                      //               height: 70.h,
                      //               width: 170.w,
                      //               decoration: BoxDecoration(
                      //                   border: Border.all(
                      //                       color: deepblue, width: 1),
                      //                   color: backgroundColor,
                      //                   borderRadius:
                      //                       BorderRadius.circular(30.r)),
                      //               child: Padding(
                      //                   padding: EdgeInsets.symmetric(
                      //                       horizontal: 15.w, vertical: 20.h),
                      //                   child: Row(
                      //                     children: [
                      //                       SizedBox(
                      //                         width: 20.w,
                      //                       ),
                      //                       Text(
                      //                         "Advanced",
                      //                         style: TextStyle(
                      //                             fontSize: 15.sp,
                      //                             color: rabbitWhite,
                      //                             fontWeight: FontWeight.w300,
                      //                             fontFamily: 'Helvetica'),
                      //                       ),
                      //                       SizedBox(
                      //                         width: 20.w,
                      //                       ),
                      //                       Align(
                      //                         alignment: Alignment.centerRight,
                      //                         child: Icon(
                      //                           Icons
                      //                               .keyboard_arrow_down_outlined,
                      //                           color: santasGray,
                      //                           size: 23.sp,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ))),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
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
                                    child: CupertinoActivityIndicator(
                                      radius: 15.sp,
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
                              ontap: controller.isDataPresent.value
                                  ? _generateImage
                                  : () {},
                              color: controller.isDataPresent.value
                                  ? deepblue
                                  : deepblue.withOpacity(0.5),
                              w: double.infinity,
                              h: 65.h,
                              child: Text(
                                "CREATE",
                                style: TextStyle(
                                    color: controller.isDataPresent.value
                                        ? Colors.blueAccent
                                        : Colors.lightBlue.withOpacity(0.5),
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
