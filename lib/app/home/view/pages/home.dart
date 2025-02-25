import 'package:aakar_ai/app/collection/view/pages/collection_screen.dart';
import 'package:aakar_ai/app/home/controller/home_controller.dart';
import 'package:aakar_ai/app/home/view/pages/home_screen.dart';
import 'package:aakar_ai/app/profile/view/pages/profile_screen.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> pages = [
    const HomeScreen(),
    CollectionScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.black,
            height: 60,
            onTap: (index) => homeController.setIndex(index),
            items: [
              BottomNavigationBarItem(
                icon: Obx(() => _buildIconNavigationBarItem(
                    0, Icons.home, "Home", Icons.home_filled)),
              ),
              BottomNavigationBarItem(
                icon: Obx(() => _buildIconNavigationBarItem(
                    1,
                    Icons.collections,
                    "Collection",
                    Icons.collections_bookmark)),
              ),
              BottomNavigationBarItem(
                icon: Obx(() => _buildIconNavigationBarItem(
                    2, Icons.person, "Profile", Icons.person_outline)),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              navigatorKey: navigatorKeys[index],
              builder: (context) => pages[index],
            );
          },
        ),
      ),
    );
  }

  Widget _buildIconNavigationBarItem(
      int index, IconData icon, String label, IconData activeIcon) {
    bool isSelected = homeController.selectedIndex.value == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isSelected ? activeIcon : icon,
          size: 24.h,
          color: isSelected ? Colors.white : santasGray,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? rabbitWhite : santasGray,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
