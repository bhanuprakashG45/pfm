import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildRowWithIcon(
  IconData icon,
  String label,
  IconData icon1, [
  Color? iconColor,
]) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(icon, color: iconColor, size: 30.sp,),
        SizedBox(width: 15.w),
        Expanded(
          flex: 1,
          child: Text('$label', style: TextStyle(fontSize: 22.sp)),
        ),
        FaIcon(icon1, size: 30.sp,),
      ],
    ),
  );
}
