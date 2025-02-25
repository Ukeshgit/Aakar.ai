import 'package:aakar_ai/app/authentication/controller/loading_indicator.dart';
import 'package:aakar_ai/app/authentication/view/pages/auth_services.dart';
import 'package:aakar_ai/app/authentication/view/pages/forgot_password_page.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isButtonEnabled = false;
  LoadingIndicator loadingIndicator = Get.put(LoadingIndicator());

  @override
  void initState() {
    super.initState();
    emailcontroller.addListener(_validateInputs);
    passwordcontroller.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      isButtonEnabled =
          emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      "Log In",
                      style: TextStyle(color: Colors.blue, fontSize: 30.sp),
                    ),
                    Text(
                      "With Email",
                      style: TextStyle(color: Colors.blue, fontSize: 30.sp),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Enter Your Email and Password",
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
                    CustomTextFiled(
                      suffixIcon: true,
                      hintText: "Password",
                      controller: passwordcontroller,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Bounce(
                          onTap: () {
                            Get.to(() => ForgotPasswordPage());
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
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
                            ontap: isButtonEnabled ? login : _showErrorSnackbar,
                            color: isButtonEnabled
                                ? deepblue
                                : deepblue.withOpacity(0.5),
                            w: double.infinity,
                            h: 65.h,
                            child: Text(
                              "SIGNING IN",
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
                          ontap: isButtonEnabled ? login : _showErrorSnackbar,
                          color: isButtonEnabled
                              ? deepblue
                              : deepblue.withOpacity(0.5),
                          w: double.infinity,
                          h: 65.h,
                          child: Text(
                            "SIGN IN",
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
                      children: [
                        const Expanded(child: Divider(color: Colors.grey)),
                        SizedBox(width: 5.w),
                        Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                        SizedBox(width: 5.w),
                        const Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Bounce(
                          onTap: () async {
                            var userCredential = await signInWithGoogle();
                            if (userCredential != null) {
                              print(
                                  "User signed in: ${userCredential.user?.displayName}");
                            } else {
                              print("Google Sign-In failed.");
                            }
                          },
                          child: const SquareTile(
                            imagelink: "assets/icons/google_logo.svg",
                          ),
                        ),
                        SizedBox(width: 15.w),
                        // const Bounce(
                        //   child: SquareTile(
                        //     imagelink: "assets/icons/apple_logo.svg",
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member? ",
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => SignupPage());
                          },
                          child: Text(
                            "Register Now",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "By Creating an account or Signing you agree\n          to our Terms and Conditions.",
                      style: TextStyle(color: Colors.white70, fontSize: 16.sp),
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

  Future<void> login() async {
    loadingIndicator.isLoading.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passwordcontroller.text.trim(),
      );
      loadingIndicator.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login failed',
          snackPosition: SnackPosition.TOP);
    }
    loadingIndicator.isLoading.value = false;
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
}
