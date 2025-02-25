import 'dart:io';

import 'package:aakar_ai/app/profile/view/widgets/custom_appbar.dart';
import 'package:aakar_ai/app/profile/view/widgets/generate_user_id.dart';
import 'package:aakar_ai/const/background_color.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:aakar_ai/app/profile/view/pages/setting_screen.dart';
import 'package:bounce/bounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final box = GetStorage();
  final ImagePicker _picker = ImagePicker();

  String? _imagePath;
  @override
  void initState() {
    super.initState();
    _imagePath = box.read('profile_image'); // Load saved image
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
        box.write('profile_image', _imagePath); // Save image path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar(
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ));
            },
            color: mako,
            text: "Profile",
            icon: Icons.settings,
            textButton: 'Settings',
          ),
          body: Stack(children: [
            GradientBackground(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Bounce(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: mako,
                          radius: 40.r,
                          backgroundImage: _imagePath != null
                              ? FileImage(File(_imagePath!))
                              : null,
                          child: _imagePath == null
                              ? Image.asset(
                                  "assets/images/user.png",
                                  fit: BoxFit.cover,
                                  height: 53.h,
                                  width: 53.w,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 26.w,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName ??
                            "Anonymous-${generateUserId()}".toString(),
                        style: TextStyle(color: rabbitWhite),
                      )
                    ],
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
