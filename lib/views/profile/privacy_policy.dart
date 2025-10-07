import 'package:priya_fresh_meats/utils/exports.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policy'),
      backgroundColor: colorscheme.onPrimary,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Disclaimer: Welcome to Chicken Booking App. Your privacy is very important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our mobile application and related services.",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: AppColor.secondaryBlack,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "1. Information We Collect",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  "We may collect the following types of information:Personal Information: Name, email address, phone number, payment details, and delivery address when you create an account or make a booking.Usage Data: Information on how you interact with our app, such as search queries, booking history, and preferences.Device Information: Mobile device model, operating system, IP address, and app version.Location Data: If enabled, we may collect your GPS location to show nearby chicken providers",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "2. How We Use Your Information",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  "We use the information we collect for purposes including: Processing your bookings and payments. Providing customer support and responding to inquiries. Improving app functionality and user experience. Sending notifications about bookings, offers, and promotions (you may opt out at any time). Ensuring safety, preventing fraud, and complying with legal requirements.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "3. Sharing of Information",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),

                Text(
                  "dataWe do not sell your personal data. However, we may share your information with: Service Providers: Payment processors, delivery partners, and customer support platforms. Legal Authorities: When required by law or to protect rights and safety.Business Transfers: In the event of a merger, acquisition, or sale of assets.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "4. Data Security",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  "We use industry-standard measures to protect your information from unauthorized access, disclosure, or misuse. However, no method of transmission over the internet or mobile networks is 100% secure.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
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
