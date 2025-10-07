import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:priya_fresh_meats/res/constents/colors.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final double textsize;
  final double borderRadius;
  final Color buttoncolor;
  const AppTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.borderRadius = 20.0,
    this.textsize = 18,
    this.buttoncolor = AppColor.primaryRed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(buttoncolor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
      ),
      onPressed: isLoading ? null : onTap,
      child:
          isLoading
              ? const CircularProgressIndicator(color: AppColor.white)
              : Text(
                text,
                style: TextStyle(
                  fontSize: textsize.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                ),
              ),
    );
  }
}
