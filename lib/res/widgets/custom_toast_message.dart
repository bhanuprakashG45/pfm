import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myself/myself.dart';
import 'package:toastification/toastification.dart';

void successPrint(String text) {
  return MySelfColor().printSuccess(text: text);
}

void errorPrint(String text) {
  return MySelfColor().printError(text: text);
}

void warningPrint(String text) {
  return MySelfColor().printWarning(text: text);
}

void variablePrint(String text) {
  return MySelfColor().colorPrint(Colors.blue, text);
}

customSuccessToast(BuildContext context, String message) {
  toastification.show(
    context: context,
    title: Text(
      message,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    animationDuration: const Duration(milliseconds: 400),
    autoCloseDuration: const Duration(seconds: 3),
    style: ToastificationStyle.minimal,
    alignment: Alignment.bottomCenter,
    type: ToastificationType.success,
    showProgressBar: true,
    borderRadius: BorderRadius.circular(20),
    margin: const EdgeInsets.symmetric(horizontal: 50),
    dragToClose: true,
    closeButtonShowType: CloseButtonShowType.always,
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

customErrorToast(BuildContext context, String message) {
  toastification.show(
    context: context,
    applyBlurEffect: false,
    title: Text(
      message,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    animationDuration: const Duration(milliseconds: 300),
    autoCloseDuration: const Duration(seconds: 3),
    style: ToastificationStyle.minimal,
    alignment: Alignment.topCenter,
    type: ToastificationType.error,
    showProgressBar: true,
    borderRadius: BorderRadius.circular(20),
    margin: EdgeInsets.symmetric(horizontal: 6.w),
    dragToClose: true,
    closeButtonShowType: CloseButtonShowType.always,
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

customRandomToast(BuildContext context, String message) {
  toastification.show(
    context: context,
    title: Text(message),
    animationDuration: const Duration(milliseconds: 300),
    autoCloseDuration: const Duration(seconds: 2),
    style: ToastificationStyle.minimal,
    alignment: Alignment.bottomCenter,
    type: ToastificationType.info,
    showProgressBar: true,
    borderRadius: BorderRadius.circular(30),
    margin: EdgeInsets.symmetric(horizontal: 50.w),
    dragToClose: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

// customSnackBar(String text, TextStyle? textstyle) {
//   return SnackBar(
//     behavior: SnackBarBehavior.floating,
//     showCloseIcon: true,
//     closeIconColor: Colors.red,
//     dismissDirection: DismissDirection.down,
//     backgroundColor: Colors.grey.withOpacity(0.2),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//     content: Text(
//       text,
//       style: textstyle,
//     ),
//   );
// }

showLoadingDialog({
  required BuildContext context,
  required String message,
  required LottieBuilder? lottie,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(20.dg),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              lottie ?? const CircularProgressIndicator(),
              Text(message, style: TextStyle(fontSize: 16.sp)),
            ],
          ),
        ),
      );
    },
  );
}

void showCustomSuccessDialog({
  required BuildContext context,
  required String message,
  required String lottieFilePath,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 5), () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context); // Close the dialog
        }
      });

      return Dialog(
        backgroundColor: Colors.black.withOpacity(0.2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              lottieFilePath,
              repeat: true,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            SizedBox(height: 3.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19.sp,
                color: Colors.white,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showCustomDialog({
  required BuildContext context,
  required Widget content, // Accept dynamic content
  required VoidCallback onCancel,
  required VoidCallback onConfirm,
  String? okbutton,
  String? cancelbutton,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        content: content, // Use dynamic content
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(dialogContext);
              onConfirm();
            },
            child: Container(
              width: 80.w,
              padding: EdgeInsets.all(10.dg),
              decoration: BoxDecoration(
                color: Colors.green.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  okbutton ?? "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          InkWell(
            onTap: () {
              onCancel();
            },
            child: Container(
              width: 80.w,
              padding:  EdgeInsets.all(10.dg),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  cancelbutton ?? "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
