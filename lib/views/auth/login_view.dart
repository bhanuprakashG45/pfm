import 'package:flutter/gestures.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _phoneController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {
        isButtonEnabled = _phoneController.text.length == 10;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    double screenheight = MediaQuery.of(context).size.height;
    final authvm = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.bottomNavBar,
                (route) => false,
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 30).r,
              child: Text(
                "SKIP",
                style: GoogleFonts.openSans(
                  fontSize: 18.sp,
                  color: AppColor.primaryRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/images/login_bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/splashfinal.png",
                      height: screenheight * 0.2,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      'Login with your mobile number',
                      style: GoogleFonts.alata(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          '+91',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          height: 24.h,
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            enabled: authvm.isLoading?false:true,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: 'Enter Mobile Number',
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.poppins(
                                color: AppColor.secondaryBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed:
                          isButtonEnabled && !authvm.isLoading
                              ? () async {
                                debugPrint(_phoneController.text);
                                await authvm.sendOtp(
                                  _phoneController.text,
                                  context,
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            authvm.isLoading
                                ? colorscheme.primary.withOpacity(0.7)
                                : isButtonEnabled
                                ? colorscheme.primary
                                : Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: authvm.isLoading ? 2 : 0,
                      ),
                      child:
                          authvm.isLoading
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                    width: 24.w,
                                    child: CircularProgressIndicator(
                                      color: colorscheme.onPrimary,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'Sending OTP...',
                                    style: GoogleFonts.alata(
                                      fontSize: 18.sp,
                                      color: colorscheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                              : Text(
                                'Get OTP',
                                style: GoogleFonts.alata(
                                  fontSize: 18.sp,
                                  color: colorscheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: 'By logging in, you agree to our ',
                        style: GoogleFonts.openSans(
                          color: AppColor.primaryBlack,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: GoogleFonts.openSans(
                              color: colorscheme.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchUrl(
                                      "https://pfm.kods.app/terms-and-condition",
                                    );
                                  },
                          ),
                          TextSpan(
                            text: ' and ',
                            style: GoogleFonts.openSans(
                              color: AppColor.primaryBlack,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.openSans(
                              color: colorscheme.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchUrl(
                                      "https://pfm.kods.app/privacy-policy",
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
