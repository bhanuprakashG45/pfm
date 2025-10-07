import 'dart:async';
import 'package:priya_fresh_meats/utils/exports.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  int _resendAfter = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _timer?.cancel();
    _resendAfter = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendAfter == 0) {
        timer.cancel();
      } else {
        setState(() => _resendAfter--);
      }
    });
  }

  bool get _isOtpComplete =>
      _otpControllers.every((controller) => controller.text.trim().isNotEmpty);

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authvm = Provider.of<LoginViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 30.h,
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/images/login_bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColor.primaryBlack,
                      ),
                    ),
                  ),

                  Text(
                    " Verify via OTP",
                    style: GoogleFonts.openSans(
                      fontSize: 22.sp,
                      color: AppColor.primaryBlackshade,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    " Enter the OTP sent to you on ${widget.phoneNumber}",
                    style: GoogleFonts.openSans(
                      fontSize: 15.sp,
                      color: AppColor.secondaryBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) => _otpBox(index)),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Didn't receive the OTP?",
                          style: GoogleFonts.openSans(
                            color: AppColor.secondaryBlack,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _resendAfter > 0
                              ? "Resend in: $_resendAfter"
                              : "Resend OTP",
                          style: GoogleFonts.openSans(
                            color: AppColor.secondaryBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: _isOtpComplete ? _verifyOtp : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _isOtpComplete
                                      ? colorScheme.primary
                                      : colorScheme.tertiary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              elevation: 0,
                            ),
                            child:
                                authvm.isVerifying
                                    ? SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: CircularProgressIndicator(
                                        color: colorScheme.onPrimary,
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                    : Text(
                                      "Continue",
                                      style: GoogleFonts.openSans(
                                        color:
                                            _isOtpComplete
                                                ? colorScheme.onPrimary
                                                : AppColor.primaryBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox(int index) {
    final colorscheme = Theme.of(context).colorScheme;

    return Consumer<LoginViewModel>(
      builder: (context, authvm, _) {
        return SizedBox(
          width: 55.w,
          child: TextField(
            cursorColor: AppColor.primaryBlack,
            controller: _otpControllers[index],
            enabled: authvm.isVerifying ? false : true,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (val) {
              if (val.isNotEmpty && index < 3) {
                FocusScope.of(context).nextFocus();
              }
              if (val.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              setState(() {});
            },
            style: GoogleFonts.openSans(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',

              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorscheme.tertiary, width: 2),
                borderRadius: BorderRadius.circular(1).r,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.primaryBlack, width: 2),
              ),
            ),
          ),
        );
      },
    );
  }

  void _verifyOtp() {
    final otp = _otpControllers.map((c) => c.text).join();
    debugPrint("Entered OTP: $otp");
    final authvm = Provider.of<LoginViewModel>(context, listen: false);
    authvm.verifyOtp(otp, widget.phoneNumber, context);
  }
}
