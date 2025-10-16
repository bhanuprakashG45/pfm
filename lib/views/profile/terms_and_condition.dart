import 'package:priya_fresh_meats/utils/exports.dart';

class TermsAndConditonView extends StatelessWidget {
  const TermsAndConditonView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        surfaceTintColor: colorScheme.onPrimary,
        shadowColor: colorScheme.onPrimary,
        elevation: 0.01,
      ),
      backgroundColor: colorScheme.onPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).r,
                border: Border.all(color: Color(0xFFDEDED1), width: 1.5.w),
                color: colorScheme.onPrimary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  _buildHeading("Terms & Conditions – Priya Fresh Meats"),
                  _buildSubText("Last updated: 11/09/2025."),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("1. Introduction"),
                  _buildParagraph(
                    "Welcome to Priya Fresh Meats. These Terms and Conditions govern your use of our meat delivery service and website. By accessing or using our service, you agree to be bound by these Terms.",
                  ),
                  _buildParagraph(
                    "Priya Fresh Meats provides fresh meat, poultry, eggs, and related products through our online platform and delivery service. These Terms apply to all users of the service, including without limitation users who are browsers, vendors, customers, merchants, and/or contributors of content.",
                  ),
                  _buildParagraph(
                    "Please read these Terms carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms. If you do not agree to all the terms and conditions of this agreement, then you may not access the website or use any services.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("2. Account Terms"),
                  _buildParagraph(
                    "To access and use certain features of Priya Fresh Meats, you may be required to register for an account. You must be at least 18 years old to create an account.",
                  ),
                  _buildSubText("Account Responsibilities:"),
                  _buildBulletList([
                    "You are responsible for maintaining the confidentiality of your account credentials.",
                    "You agree to provide accurate, current, and complete information during registration.",
                    "You must notify us immediately of any unauthorized use of your account.",
                    "We reserve the right to refuse service, terminate accounts, or remove content at our discretion.",
                  ]),
                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "Priya Fresh Meats reserves the right to remove or reclaim any usernames at its sole discretion. You acknowledge that Priya Fresh Meats is not liable for any losses caused by any unauthorized use of your account.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("3. Ordering Process"),
                  _buildParagraph(
                    "Orders are placed through our website or mobile application. By placing an order, you make an offer to purchase the products selected.",
                  ),
                  _buildSubText("Order Confirmation:"),
                  _buildBulletList([
                    "You will receive an order confirmation email after placing your order.",
                    "We reserve the right to refuse or cancel any order for any reason",
                    "Certain orders may require additional verification or information",
                    "Orders are subject to product availability",
                  ]),
                  SizedBox(height: 10.h),

                  _buildParagraph(
                    "In the event that a product is mispriced, we may refuse or cancel orders for that product. If a product is unavailable after you have placed an order, we will notify you and refund any amounts charged for that product.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("4. Payment & Pricing"),
                  _buildParagraph(
                    "All prices are shown in your local currency and include applicable taxes unless otherwise stated. We reserve the right to change prices at any time without notice.",
                  ),
                  _buildSubText("Payment Methods:"),
                  _buildBulletList([
                    "We accept major credit cards, debit cards, and digital payment methods.",
                    "Payment is processed at the time of order placement.",
                    "All transactions are secure and encrypted.",
                    "You agree to provide current and valid payment information.",
                  ]),
                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "In cases of suspected fraud, we reserve the right to cancel any order. You are responsible for any fees or charges incurred due to insufficient funds or other payment issues.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("5. Delivery Policy"),
                  _buildParagraph(
                    "We deliver to the address specified during checkout. Delivery times are estimates and not guaranteed. Factors such as traffic, weather, and other conditions may affect delivery times.",
                  ),
                  _buildSubText("Delivery Requirements:"),
                  _buildBulletList([
                    "Someone must be available to receive the delivery.",
                    "Perishable items cannot be left unattended.",
                    "Delivery fees vary based on location and order size.",
                    "We may require ID verification for alcohol-containing products.",
                  ]),

                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "If no one is available to receive the delivery, we will attempt to contact you. After multiple failed delivery attempts, your order may be returned to us, and restocking fees may apply.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("6. Product Quality"),
                  _buildParagraph(
                    'We take pride in providing high-quality meat products. All products are sourced from reputable suppliers and handled according to strict food safety standards.',
                  ),
                  _buildSubText("Quality Assurance:"),
                  _buildBulletList([
                    "Products are stored and transported at proper temperatures.",
                    "We follow all applicable food safety regulations.",
                    "Products are packaged to maintain freshness and prevent contamination.",
                    "We conduct regular quality checks.",
                  ]),
                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "While we take every precaution to ensure product quality, we cannot guarantee that products will always meet every customer's expectations due to the natural variations in meat products.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("7. Liability"),
                  _buildParagraph(
                    "Priya Fresh Meats's liability is limited to the maximum extent permitted by law. We are not liable for any indirect, incidental, special, consequential, or punitive damages.",
                  ),
                  _buildSubText("Limitations:"),
                  _buildBulletList([
                    "We are not liable for improper storage or handling after delivery.",
                    "We are not responsible for allergic reactions or food sensitivities.",
                    "Our total liability for any claim shall not exceed the purchase price of the products.",
                    "We are not liable for delays beyond our reasonable control.",
                  ]),
                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "You agree to properly handle, store, and cook all products according to food safety guidelines. Priya Fresh Meats is not responsible for any illness or injury resulting from improper handling, storage, or preparation of products.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("8. User Conduct"),
                  _buildParagraph(
                    "You agree to use Priya Fresh Meats services only for lawful purposes and in accordance with these Terms. You agree not to use our services:",
                  ),
                  _buildSubText("Prohibited Activities:"),
                  _buildBulletList([
                    "In any way that violates any applicable law or regulation.",
                    "To engage in any fraudulent or deceptive activities.",
                    "To harass, abuse, or harm another person.",
                    "To interfere with or disrupt the service or servers.",
                    "To attempt to gain unauthorized access to any part of the service.",
                  ]),
                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "We reserve the right to terminate or suspend your account and access to the service for conduct that we determine, in our sole discretion, violates these Terms or is harmful to other users, us, or third parties, or for any other reason.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("9. Changes to Terms"),
                  _buildParagraph(
                    "We may update these Terms from time to time to reflect changes in our practices, service features, or legal requirements. We will notify you of any material changes by posting the new Terms on this page.",
                  ),
                  _buildSubText("Notification of Changes:"),
                  _buildBulletList([
                    "We will update the 'Last updated' date at the top of these Terms.",
                    "For significant changes, we may provide additional notice.",
                    "Continued use of the service after changes constitutes acceptance.",
                    "We encourage you to review these Terms periodically.",
                  ]),
                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "If you do not agree to the updated Terms, you must stop using the service. Material changes will not be applied retroactively without your consent to the extent required by law.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("Acceptance of Terms"),
                  _buildParagraph(
                    "By using Priya Fresh Meats services Powered by THE BRIGHT CARS, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions. If you do not agree to these Terms, you may not use our services.",
                  ),

                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSubText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xFFA86523),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 15.sp,
          color: Color(0xFF19183B),
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xFFD32F2F),
        ),
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items
              .map(
                (item) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("• ", style: TextStyle(fontSize: 15.sp)),
                      Expanded(
                        child: Text(
                          item,
                          style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            color: Color(0xFF19183B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }
}
