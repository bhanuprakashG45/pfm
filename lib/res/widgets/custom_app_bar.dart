import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final double height;
  final VoidCallback? onBackPressed;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.height = 60.0,
    this.onBackPressed,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height.h);

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return AppBar(
      toolbarHeight: height.h,
      leading:
          automaticallyImplyLeading == false
              ? SizedBox.shrink()
              : IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 25.0.sp),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
              ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 22.0.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: centerTitle,
      surfaceTintColor: colorscheme.onPrimary,
      backgroundColor: colorscheme.onPrimary,
      shadowColor: colorscheme.onPrimary,
      elevation: 0.1,
    );
  }
}
