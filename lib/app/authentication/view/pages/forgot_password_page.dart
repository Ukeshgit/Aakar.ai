import 'package:aakar_ai/app/authentication/controller/loading_indicator.dart';
import 'package:aakar_ai/app/authentication/view/pages/auth_services.dart';
import 'package:aakar_ai/app/authentication/view/pages/signup_page.dart';
import 'package:aakar_ai/app/authentication/view/widgets/square_tile.dart';
import 'package:aakar_ai/app/profile/view/widgets/custom_button.dart';
import 'package:aakar_ai/app/widgets/custom_text_input_field.dart';
import 'package:aakar_ai/const/background_color.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:bounce/bounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:aakar_ai/app/authentication/view/pages/auth_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<ForgotPasswordPage> {
  TextEditingController emailcontroller = TextEditingController();
  LoadingIndicator loadingIndicator = Get.put(LoadingIndicator());
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailcontroller.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      isButtonEnabled = emailcontroller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: rabbitWhite,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            GradientBackground(),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        Icons.lock,
                        color: Colors.blue,
                        size: 70.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Enter Your Email to get a link to reset your password",
                      style: TextStyle(
                        color: Colors.blue.withOpacity(0.7),
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFiled(
                      hintText: "Email ",
                      controller: emailcontroller,
                    ),
                    SizedBox(height: 18.h),
                    SizedBox(height: 16.h),
                    Obx(() {
                      if (loadingIndicator.isLoading.value) {
                        return Bounce(
                          child: CustomButton1(
                            prefix: isButtonEnabled
                                ? Positioned(
                                    left: 15.w,
                                    child: SizedBox(
                                      height: 35.h,
                                      width: 35.w,
                                      child: CupertinoActivityIndicator(
                                        radius: 15.sp,
                                        color: edtraaViolet,
                                      ),
                                    ),
                                  )
                                : null,
                            ontap: isButtonEnabled
                                ? resetPassword
                                : _showErrorSnackbar,
                            color: isButtonEnabled
                                ? deepblue
                                : deepblue.withOpacity(0.5),
                            w: double.infinity,
                            h: 65.h,
                            child: Text(
                              "SENDING EMAIL",
                              style: TextStyle(
                                color: isButtonEnabled
                                    ? Colors.lightBlue
                                    : Colors.lightBlue.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                                fontFamily: "HelveticaMedium",
                              ),
                            ),
                          ),
                        );
                      }
                      return Bounce(
                        child: CustomButton1(
                          ontap: isButtonEnabled
                              ? resetPassword
                              : _showErrorSnackbar,
                          color: isButtonEnabled
                              ? deepblue
                              : deepblue.withOpacity(0.5),
                          w: double.infinity,
                          h: 65.h,
                          child: Text(
                            "SEND EMAIL",
                            style: TextStyle(
                              color: isButtonEnabled
                                  ? Colors.lightBlue
                                  : Colors.lightBlue.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp,
                              fontFamily: "HelveticaMedium",
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 15.w),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackbar() {
    loadingIndicator.isLoading.value = false;
    Get.snackbar(
      "Error",
      "Please fill all the fields",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      messageText: const Text(
        "Please fill all the fields",
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

  void resetPassword() async {
    try {
      loadingIndicator.isLoading.value = true;
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      Get.snackbar('Success', 'Password reset link sent to your email',
          snackPosition: SnackPosition.TOP);
      loadingIndicator.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          snackPosition: SnackPosition.TOP);
      loadingIndicator.isLoading.value = false;
    } finally {
      loadingIndicator.isLoading.value = false;
    }
  }
}
