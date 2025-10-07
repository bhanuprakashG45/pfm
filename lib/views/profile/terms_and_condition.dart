import 'package:priya_fresh_meats/utils/exports.dart';

class TermsAndConditonView extends StatelessWidget {
  const TermsAndConditonView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(title: 'Terms and Conditions'),
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
                  "Terms and Conditions",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.secondaryBlack,
                  ),
                ),
                Text(
                  "Effective Date: Your Effective Date\nApp Name: Priya Fresh Meats",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Welcome to Priya Fresh Meats! By downloading, installing, or using our app, you agree to comply with and be bound by the following Terms and Conditions. Please read them carefully.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "1. Eligibility",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "You must be at least 18 years old to use this app and place orders.\nBy using the app, you confirm that the information you provide is true and accurate.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "2. Services",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "Priya Fresh Meats provides delivery of fresh chicken and related products to your doorstep.\nAvailability of products is subject to stock, delivery location, and serviceable areas.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "3. Ordering and Payment",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "Orders can be placed only through the Priya Fresh Meats app.\nPrices are displayed in the app and may vary based on weight, product, or promotions.\nPayments can be made online through secure payment gateways or Cash on Delivery (where available).\nOnce confirmed, orders cannot be cancelled or modified after a certain cutoff time.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "4. Delivery",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "Delivery timelines are estimates and may vary due to traffic, weather, or other factors beyond our control.\nCustomers must be available to receive the order at the delivery address.\nIf delivery is unsuccessful due to incorrect information or unavailability, additional charges may apply.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "5. Product Quality and Freshness",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "We strive to deliver high-quality, fresh products.\nIf you receive a damaged or spoiled product, you must raise a complaint within 2 hours of delivery with photos as proof.\nOur decision on refunds or replacements will be final.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "6. User Responsibilities",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "You agree not to misuse the app for unlawful purposes.\nYou will not attempt to disrupt app functionality, hack into systems, or misuse promotional offers.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "7. Refunds & Cancellations",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "Refunds (if applicable) will be processed to the original payment method within 5–7 business days.\nRefunds are only applicable in cases of:\n- Product unavailability\n- Wrong or spoiled product delivered\nNo refunds will be given for customer error (e.g., wrong address, unavailability at delivery time).",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "8. Intellectual Property",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "All logos, brand names, and content on the app belong to Priya Fresh Meats.\nYou may not copy, reproduce, or use our intellectual property without prior permission.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "9. Limitation of Liability",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "Priya Fresh Meats shall not be liable for delays, indirect losses, or damages arising from the use of our app or services.\nOur maximum liability in any case will be limited to the value of your order.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "10. Privacy",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "We collect and use your personal data in accordance with our Privacy Policy.\nBy using the app, you consent to our data practices.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "11. Changes to Terms",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "Priya Fresh Meats reserves the right to update or modify these Terms at any time.\nContinued use of the app after changes implies acceptance of the updated Terms.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "12. Governing Law",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "These Terms shall be governed by and interpreted under the laws of Your Country/State.\nAny disputes shall be subject to the exclusive jurisdiction of courts in Your City.",
                  style: GoogleFonts.roboto(
                    color: AppColor.secondaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "13. Contact Us",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  "For queries or complaints, contact us at:\n📧 Email: priyafreshmeats@gmail.com\n📞 Phone: 9686068687 & 9845052666",
                  style: GoogleFonts.roboto(
                    color: AppColor.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
