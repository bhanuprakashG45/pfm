import 'dart:ui';
import 'package:priya_fresh_meats/utils/exports.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final loginprovider = Provider.of<LoginViewModel>(context, listen: false);
      await loginprovider.sendDeviceToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.welcomeBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius:
                      BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ).r,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20, right: 10, left: 10).r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to ",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryBlackshade,
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(width: 5.w),
                          Image.asset(
                            "assets/images/logintext.png",
                            height: 25.h,
                            color: colorScheme.primary,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Where Quality Meats \n Freshness!",
                        style: GoogleFonts.poppins(
                          color: AppColor.black,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56.0),
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.poppins(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
