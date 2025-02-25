import 'package:aakar_ai/app/profile/view/widgets/custom_button.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  final box = GetStorage();
  List<String> prompts = [];
  void deletePrompt(int index) {
    prompts.removeAt(index);
    box.write('prompts', prompts);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadPrompts();
  }

  void loadPrompts() {
    prompts = box.read<List>('prompts')?.cast<String>() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF0D0D4D),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close_rounded,
              color: rabbitWhite,
            ),
          ),
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.only(right: 20.h),
            child: Text(
              "Prompt History",
              style: TextStyle(
                color: rabbitWhite,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        body: Stack(children: [
          Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D0D4D), // dark blue color towards the bottom
                mako // black color at the top
              ],
            ),
          )),
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r)),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 20.h),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            prompts.isEmpty
                                ? Center(
                                    child: Text(
                                      "No prompts saved yet",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: 'Helvetica',
                                          color: rabbitWhite),
                                    ),
                                  )
                                : Container(
                                    height: prompts.length * 80.h,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: prompts.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          decoration: BoxDecoration(
                                            color: mako,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              prompts[index],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontFamily: 'Helvetica',
                                                  color: rabbitWhite),
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: rabbitWhite),
                                              onPressed: () =>
                                                  deletePrompt(index),
                                            ),
                                          ),
                                        );
                                      },
                                    ))
                          ]))))
        ]));
  }

  Widget settingInfo(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Icon(
            icon,
            color: rabbitWhite,
            size: 18.sp,
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            text,
            style: TextStyle(
                color: rabbitWhite,
                fontSize: 18.sp,
                fontFamily: 'HelveticaBold'),
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            color: mako,
            size: 30.sp,
          )
        ],
      ),
    );
  }
}
