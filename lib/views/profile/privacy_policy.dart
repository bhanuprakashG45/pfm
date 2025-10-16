import 'package:priya_fresh_meats/utils/exports.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
                  _buildHeading("Privacy policy – Priya Fresh Meats"),
                  _buildSubText("Last updated: 11/09/2025."),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("Introduction"),
                  _buildParagraph(
                    "Welcome to Priya Fresh Meats, your trusted meat delivery service. We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our meat delivery application and services.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("1. Information We Collect"),
                  _buildSubText("Personal Information:"),
                  _buildParagraph(
                    "When you create an account, we collect your name, email address, phone number, and delivery address.",
                  ),
                  _buildSubText("Payment Information:"),

                  _buildParagraph(
                    "We collect payment details including credit card information, billing address, and transaction history through secure payment processors.",
                  ),
                  _buildSubText("Order Information:"),
                  _buildParagraph(
                    "Details about your meat, egg, chicken, and related product orders, preferences, and delivery instructions.",
                  ),
                  _buildSubText("Device Information:"),
                  _buildParagraph(
                    "IP address, browser type, device type, and operating system when you use our application.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("2. How We Use Your Information"),

                  _buildBulletList([
                    "Process and deliver your meat and related product orders.",
                    "Manage your account and provide customer support.",
                    "Send order confirmations, delivery updates, and receipts.",
                    "Personalize your experience with product recommendations.",
                    "Process payments and prevent fraudulent transactions",
                    "Send promotional offers and updates (with your consent)",
                    "Improve our services and develop new features.",
                  ]),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("3. Data Sharing and Disclosure"),
                  _buildSubText("Delivery Partners:"),
                  _buildParagraph(
                    "We share your delivery address and contact information with our delivery personnel to fulfill your orders.",
                  ),
                  _buildSubText("Payment Processors: "),
                  _buildParagraph(
                    "Your payment information is shared with secure third-party payment processors.",
                  ),
                  _buildSubText("Service Providers: "),
                  _buildParagraph(
                    "We may share information with vendors who help us operate our services (e.g., cloud hosting, analytics).",
                  ),
                  _buildSubText("Legal Requirements:"),
                  _buildParagraph(
                    "We may disclose information when required by law or to protect our rights and safety.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("4. Data Security"),
                  _buildParagraph(
                    "We implement industry-standard security measures to protect your personal information, including:",
                  ),
                  _buildBulletList([
                    "SSL encryption for all data transmissions.",
                    "Secure payment processing through PCI-compliant providers.",
                    "Regular security audits and monitoring.",
                    "Access controls and authentication measures.",
                    "Secure data storage with encryption at rest.",
                  ]),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("5. Your Rights"),

                  _buildBulletList([
                    "Access and review your personal information.",
                    "Update or correct inaccurate information.",
                    "Request deletion of your account and data.",
                    "Opt-out of marketing communications.",
                    "Export your data in a portable format.",
                    "Withdraw consent for data processing.",
                  ]),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSectionTitle("6. Cookies and Tracking"),
                  _buildParagraph(
                    "We use cookies and similar technologies to:",
                  ),
                  _buildBulletList([
                    "Remember your preferences and login status.",
                    "Analyze website traffic and usage patterns.",
                    "Personalize your shopping experiencerice.",
                    "Deliver targeted advertisements.",
                  ]),
                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "You can manage cookie preferences through your browser settings.",
                  ),

                  Divider(color: Color(0xFFDEDED1), thickness: 1),
                  Container(
                    padding: EdgeInsets.all(10).r,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("7. Contact Us"),
                        _buildParagraph(
                          "If you have any questions about this Privacy Policy or our data practices, please contact us:",
                        ),
                        SizedBox(height: 10.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                "Email: priyafreshmeats@gmail.com",
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                "Phone: +91 9686068687\n+91 9845052666",
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                "Address: No.175, 1st Floor,\n15th Main, M C Layout, Vprov,\nVijaya Nagar, Bengaluru,\nKarnataka, 560040",
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _buildParagraph(
                    "By using Priya Fresh Meats services Powered by THE BRIGHT CARS, you acknowledge that you have read and understood this Privacy Policy and agree to the collection and use of your information as described.",
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
