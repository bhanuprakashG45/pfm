import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:priya_fresh_meats/res/constents/colors.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController
  controller; // Accept a controller for external usage
  final Function(String)? onChanged; // Callback for text changes

  const SearchTextField({Key? key, required this.controller, this.onChanged})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      height: 55.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColor.primaryRed, width: 2),
      ),
      child: TextFormField(
        controller: controller,
        cursorWidth: 1.5,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          border: InputBorder.none,
          icon: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: AppColor.secondaryBlack,
            size: 23.sp,
          ),
          hintText: "Search for chicken here",
          hintStyle: TextStyle(color: AppColor.secondaryBlack, fontSize: 20.sp),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
