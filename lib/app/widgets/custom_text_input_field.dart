import 'package:aakar_ai/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon = false,
  });
  final controller;
  final String hintText;
  final bool suffixIcon;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: Colors.blue),
        controller: widget.controller,
        obscureText: !widget.suffixIcon ? false : _isObscured,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 16.sp),
          labelText: widget.hintText,
          labelStyle: TextStyle(fontSize: 16.sp),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.sp),
              borderSide: BorderSide(color: Colors.grey.shade100)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mako),
              borderRadius: BorderRadius.circular(25.sp)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mako),
              borderRadius: BorderRadius.circular(25.sp)),
          suffixIcon: widget.suffixIcon
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  color: Colors.grey.shade600,
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
        ));
  }
}
