// import 'package:aakar_ai/features/app/global/theme/background_color.dart';
// import 'package:aakar_ai/features/app/global/theme/colors.dart';
// import 'package:aakar_ai/features/user/widgets/custom_appbar.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CollectionScreen extends StatefulWidget {
//   @override
//   State<CollectionScreen> createState() => _CollectionScreenState();
// }

// class _CollectionScreenState extends State<CollectionScreen> {
//   final CarouselController _carouselController1 = CarouselController();
//   final CarouselController _carouselController2 = CarouselController();
//   int currentIndex1 = 0;
//   int currentIndex2 = 0;
//   bool _carouselsRunning = false;

//   List imageList = [
//     {"id": 1, "image_path": "assets/images/carousel1.jpg"},
//     {"id": 2, "image_path": "assets/images/carousel2.png"},
//     {"id": 3, "image_path": "assets/images/carousel3.jpg"},
//   ];

//   List imageList2 = [
//     {"id": 1, "image_path": "assets/images/carousel4.jpg"},
//     {"id": 2, "image_path": "assets/images/carousel5.jpg"},
//     {"id": 3, "image_path": "assets/images/carousel6.jpg"},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!_carouselsRunning) {
//         _carouselsRunning = true;
//         _startCarousels();
//       }
//     });
//   }

//   void _startCarousels() {
//     Future.delayed(const Duration(milliseconds: 1000), () {
//       if (mounted) {
//         _carouselController1.previousPage(
//           duration: const Duration(milliseconds: 1000),
//           curve: Curves.linear,
//         );
//         _carouselController2.nextPage(
//           duration: const Duration(milliseconds: 1000),
//           curve: Curves.linear,
//         );
//         _startCarousels();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: CustomAppBar(
//         ontap: () {},
//         color: Colors.black,
//         text: "AI STORE",
//         icon: Icons.star_outline_outlined,
//         textButton: 'STORE+',
//       ),
//       body: Stack(
//         children: [
//           GradientBackground(),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "AI Avatar",
//                   style: TextStyle(
//                     color: rabbitWhite,
//                     fontSize: 20.sp,
//                     fontFamily: "Helvetica",
//                   ),
//                 ),
//                 CarouselSlider(
//                   carouselController: _carouselController1,
//                   options: CarouselOptions(
//                     height: 168.w,
//                     pageSnapping: false,
//                     enableInfiniteScroll: true,
//                     scrollPhysics: const NeverScrollableScrollPhysics(),
//                     aspectRatio: 0.76.w,
//                     viewportFraction: 0.38.w,
//                   ),
//                   items: imageList
//                       .map(
//                         (item) => ClipRRect(
//                           borderRadius: BorderRadius.circular(10.r),
//                           child: Image.asset(
//                             item['image_path'],
//                             height: 168.w,
//                             width: 128.w,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//                 SizedBox(
//                   height: 16.w,
//                 ),
//                 CarouselSlider(
//                   carouselController: _carouselController2,
//                   options: CarouselOptions(
//                     height: 168.w,
//                     pageSnapping: false,
//                     enableInfiniteScroll: true,
//                     scrollPhysics: const NeverScrollableScrollPhysics(),
//                     aspectRatio: 0.76.w,
//                     viewportFraction: 0.38.w,
//                   ),
//                   items: imageList2
//                       .map(
//                         (item) => ClipRRect(
//                           borderRadius: BorderRadius.circular(10.r),
//                           child: Image.asset(
//                             item['image_path'],
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
