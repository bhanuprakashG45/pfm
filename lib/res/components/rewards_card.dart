import 'dart:ui' as ui;
import 'package:priya_fresh_meats/utils/exports.dart';

class RewardsCard extends StatefulWidget {
  const RewardsCard({super.key});

  @override
  State<RewardsCard> createState() => _RewardsCardState();
}

class _RewardsCardState extends State<RewardsCard> {
  final List<String> messages = [
    "20% off \non your first 5 orders!",
    "Free delivery  \non orders above ₹499!",
    "Get rewards  \npoints on every order!",
    "Special deals \nevery weekend!",
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTextRotation();
  }

  void _startTextRotation() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return false;
      setState(() {
        _currentIndex = (_currentIndex + 1) % messages.length;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shadowColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            elevation: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.all(16.0).r,
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: const AssetImage("assets/images/login_bg.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.2),
                        BlendMode.dstATop,
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Colors.orange.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 600),
                              transitionBuilder: (
                                Widget child,
                                Animation<double> animation,
                              ) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: Text(
                                messages[_currentIndex],
                                key: ValueKey<int>(_currentIndex),
                                style: GoogleFonts.roboto(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'Code: 20FLAT',
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Lottie.asset("assets/json/Discount.json", height: 80.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -8.h,
            left: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                "WELCOME REWARDS",
                style: GoogleFonts.roboto(
                  letterSpacing: 2.0,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
