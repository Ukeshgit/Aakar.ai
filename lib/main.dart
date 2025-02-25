import 'package:aakar_ai/app/authentication/view/pages/login_page.dart';
import 'package:aakar_ai/app/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBv6ajVNGcXLtWOe2L4lGbD-vpe_DoXRgs',
          appId: "1:161273741907:android:83d9874d166f28b069bca6",
          messagingSenderId: "161273741907",
          projectId: "aakar-fca3e"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 815),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: GetMaterialApp(
                theme: ThemeData.light()
                    .copyWith(scaffoldBackgroundColor: Colors.white),
                debugShowCheckedModeBanner: false,
                home: child,
              ),
            ),
        child: const SplashScreen());
  }
}
