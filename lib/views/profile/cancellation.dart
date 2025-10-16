import 'package:priya_fresh_meats/utils/exports.dart';

class CancellationPolicyView extends StatelessWidget {
  const CancellationPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cancellation Policy',
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
                  _buildHeading(
                    "Cancellation & Refund Policy – Priya Fresh Meats",
                  ),
                  _buildSubText("Updated on : October 14, 2025."),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSection("1. Order Cancellation by Customer", [
                    "Customers may cancel their order within 5 minutes of placement at no cost.",
                    "Once the order is processed, cancellation may not be possible.",
                    "As of now, only online payment is accepted; Cash on Delivery (COD) is unavailable.",
                    "If eligible, refunds will be processed within 1–7 working days.",
                    "Frequent cancellations may result in temporary account restrictions.",
                  ]),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSection("2. Order Rescheduling by Customer", [
                    "Rescheduling is allowed only before the order is processed.",
                    "Requests must be made at least 1 hour prior to the scheduled delivery time.",
                    "Product availability and delivery slot may affect rescheduling options.",
                  ]),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSection(
                    "3. Cancellation or Reschedule by Priya Fresh Meats",
                    [
                      "Orders may be cancelled or rescheduled due to product unavailability, incorrect order info, or operational reasons.",
                      "Customers will be notified immediately via email/app notification.",
                      "Refunds (if applicable) will be processed within 1–7 working days.",
                    ],
                  ),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSection("4. Refund Conditions", [
                    "Refunds are only processed for:",
                    "- Orders cancelled by Priya Fresh Meats",
                    "- Orders cancelled by customers within the allowed window",
                    "Refunds are credited back to the original payment method.",
                    "Bank processing times may affect the exact receipt of refund.",
                  ]),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSection("5. Non-Cancellable Orders", [
                    "Orders already dispatched",
                    "Bulk or wholesale orders",
                    "Promotional or limited-time deals",
                  ]),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSection("6. Failed Delivery or No-Show", [
                    "If the customer is unavailable at the delivery time, the order will be marked as Failed Delivery.",
                    "No refund will be issued for failed delivery.",
                    "Re-delivery may incur additional charges based on the situation.",
                  ]),
                  Divider(color: Color(0xFFDEDED1), thickness: 1),

                  _buildSection("7. Customer Support", [
                    "📧 Email: priyafreshmeats@gmail.com",
                    "📞 Phone: +91 9686068687 / +91 9845052666",
                    "For cancellation or reschedule queries, reach out to our support team during business hours.",
                  ]),

                  SizedBox(height: 20.h),
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

  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildSectionTitle(title), _buildBulletList(items)],
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
                            height: 1.4,
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
