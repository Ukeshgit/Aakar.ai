import 'package:aakar_ai/app/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // await GetStorage.init();
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
        child: SplashScreen());
  }
}
