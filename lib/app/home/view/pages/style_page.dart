import 'package:aakar_ai/app/profile/view/widgets/custom_button.dart';
import 'package:aakar_ai/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class StylePage extends StatefulWidget {
  const StylePage({super.key});

  @override
  State<StylePage> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<StylePage> {
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
              "Style",
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
          Center(
            child: Text(
              "This feature is not currently avaiable",
              style: TextStyle(color: Colors.white),
            ),
          )
        ]));
  }
}
