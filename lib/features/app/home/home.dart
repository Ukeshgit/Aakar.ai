import 'package:aakar_ai/features/app/collection/collection_screen.dart';
import 'package:aakar_ai/features/app/global/profile/profile_screen.dart';
import 'package:aakar_ai/features/app/global/theme/colors.dart';
import 'package:aakar_ai/features/app/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  final List<Widget> pages = [
    const HomeScreen(),
    Container(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index && navigatorKeys[index].currentState != null) {
      navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
      navigatorKeys[index].currentState!.pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => pages[index],
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Colors.blueAccent,
          backgroundColor: Colors.black,
          height: 60,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: _buildIconNavigationBarItem(
                  0, Icons.home, "Home", Icons.home_filled),
            ),
            BottomNavigationBarItem(
              icon: _buildIconNavigationBarItem(1, Icons.collections,
                  "Collection", Icons.collections_bookmark),
            ),
            BottomNavigationBarItem(
              icon: _buildIconNavigationBarItem(
                  2, Icons.person, "Profile", Icons.person_outline),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: navigatorKeys[index],
            builder: (context) {
              return pages[index];
            },
          );
        },
      ),
    );
  }

  Widget _buildIconNavigationBarItem(
      int index, IconData icon, String label, IconData activeIcon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _selectedIndex == index ? activeIcon : icon,
          size: 24.h,
          color: _selectedIndex == index ? Colors.white : santasGray,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: TextStyle(
              color: _selectedIndex == index ? rabbitWhite : santasGray,
              fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
