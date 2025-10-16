import 'package:priya_fresh_meats/utils/exports.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  Future<void> _launchDialer(String phoneNumber) async {
    final Uri uri = Uri(scheme: "tel", path: phoneNumber);
    if (!await launchUrl(uri)) {
      throw "Could not launch $uri";
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri uri = Uri(
      scheme: "mailto",
      path: email,
      query: "subject=Customer Support&body=Hello Team,",
    );
    if (!await launchUrl(uri)) {
      throw "Could not launch $uri";
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(title: 'Contact Us'),
      backgroundColor: colorscheme.onPrimary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/contact_us.png",
                  height: 200.h,
                  width: 300.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 24.h),
                Text(
                  "Tingling fingertips?\nThat's a magnetic urge to get in touch with us!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.secondaryBlack,
                  ),
                ),
                SizedBox(height: 40.h),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: AppColor.danger, width: 1.w),
                      ),
                    ),
                    onPressed: () {
                      _launchDialer("9686068687"); 
                    },
                    child: Text(
                      "Call Us",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.danger,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: AppColor.danger, width: 1.w),
                      ),
                    ),
                    onPressed: () {
                      _launchEmail(
                        "priyafreshmeats@gmail.com",
                      ); 
                    },
                    child: Text(
                      "Drop Us a Line",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.danger,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
