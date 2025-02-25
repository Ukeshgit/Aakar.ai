import 'package:aakar_ai/app/authentication/controller/loading_indicator.dart';
import 'package:aakar_ai/app/authentication/view/pages/login_page.dart';
import 'package:aakar_ai/app/authentication/view/widgets/square_tile.dart';
import 'package:aakar_ai/app/home/view/pages/home.dart';
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

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool isButtonEnabled = false;
  LoadingIndicator loadingIndicator = Get.put(LoadingIndicator());
  @override
  void initState() {
    super.initState();
    emailcontroller.addListener(_validateInputs);
    passwordcontroller.addListener(_validateInputs);
    confirmpasswordcontroller.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      isButtonEnabled = emailcontroller.text.isNotEmpty &&
          passwordcontroller.text.isNotEmpty &&
          confirmpasswordcontroller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final LoadingIndicator loadingIndicator = Get.put(LoadingIndicator());

    void signup() async {
      try {
        loadingIndicator.isLoading.value = true;
        if (passwordcontroller.text.toString() ==
            confirmpasswordcontroller.text.toString()) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailcontroller.text.toString(),
              password: passwordcontroller.text.toString());
          Get.to(() => Home());
        } else {
          Get.snackbar("Error", "Password doesn't match ");
          loadingIndicator.isLoading.value = false;
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'Login failed',
            snackPosition: SnackPosition.TOP);
        loadingIndicator.isLoading.value = false;
      } finally {
        loadingIndicator.isLoading.value = false; // Hide loading indicator
      }
    }

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
                    //logo
                    Center(
                      child: Icon(
                        Icons.lock,
                        color: Colors.blue,
                        size: 70.sp,
                      ),
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue, fontSize: 30.sp),
                    ),

                    Text(
                      "With Email",
                      style: TextStyle(color: Colors.blue, fontSize: 30.sp),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "Enter Your information to setup your account",
                      style: TextStyle(
                          color: Colors.blue.withOpacity(0.7), fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    //Username and password field
                    CustomTextFiled(
                      hintText: "Email ",
                      controller: emailcontroller,
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    CustomTextFiled(
                      suffixIcon: true,
                      hintText: "Password",
                      controller: passwordcontroller,
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    CustomTextFiled(
                      suffixIcon: true,
                      hintText: "Confirm password",
                      controller: confirmpasswordcontroller,
                    ),

                    SizedBox(
                      height: 26.h,
                    ),

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
                            ontap:
                                isButtonEnabled ? signup : _showErrorSnackbar,
                            color: isButtonEnabled
                                ? deepblue
                                : deepblue.withOpacity(0.5),
                            w: double.infinity,
                            h: 65.h,
                            child: Text(
                              "CREATING ACCOUNT",
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
                          ontap: isButtonEnabled ? signup : _showErrorSnackbar,
                          color: isButtonEnabled
                              ? deepblue
                              : deepblue.withOpacity(0.5),
                          w: double.infinity,
                          h: 65.h,
                          child: Text(
                            "CREATE ACCOUNT",
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
                    SizedBox(
                      height: 50.h,
                    ),

                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                        InkWell(
                          onTap: () => Get.to(() => LoginPage()),
                          child: Text(
                            "Login Now",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
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
}

void _showErrorSnackbar() {
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
