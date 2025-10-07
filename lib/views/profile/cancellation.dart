import 'package:priya_fresh_meats/utils/exports.dart';

class CancellationPolicyView extends StatelessWidget {
  const CancellationPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(title: 'Cancellation Policy'),
      backgroundColor: colorscheme.onPrimary,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cancellation & Reschedule Policy",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColor.secondaryBlack,
                ),
              ),
              Text(
                "Effective Date: \nApp Name: Priya Fresh Meats",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: AppColor.secondaryBlack,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 20.h),

              _section(
                "1. Order Cancellation by Customer",
                "• Customers may cancel an order within 5 minutes of placing it at no extra cost.\n\n"
                    "• Once an order is confirmed and processing begins, cancellation may not be possible.\n\n"
                    "• If cancellation is permitted, a cancellation fee (up to [X%] of order value) may be charged.\n\n"
                    "• Frequent cancellations of COD orders may result in suspension of the COD option.",
              ),

              _section(
                "2. Order Rescheduling by Customer",
                "• Rescheduling is subject to delivery personnel availability and product freshness.\n\n"
                    "• Requests must be made at least 1 hour before the scheduled delivery.\n\n"
                    "• Not available during peak hours or promotional sales.",
              ),

              _section(
                "3. Cancellation or Reschedule by Priya Fresh Meats",
                "• Orders may be cancelled/rescheduled due to product unavailability, incorrect info, or unforeseen circumstances.\n\n"
                    "• Customers will be notified and refunds (if applicable) processed within 5–7 business days.",
              ),

              _section(
                "4. Refunds for Cancelled Orders",
                "• Refunds only apply when:\n"
                    "- Order cancelled by Priya Fresh Meats\n"
                    "- Order cancelled by customer within allowed window\n\n"
                    "• Refunds will be processed within 5–7 business days.",
              ),

              _section(
                "5. Non-Cancellable Orders",
                "• Special promotional deals\n"
                    "• Bulk/wholesale orders\n"
                    "• Orders already dispatched",
              ),

              _section(
                "6. No-Show or Failed Delivery",
                "• If the customer is unavailable at delivery time, the order will be marked as Failed Delivery.\n\n"
                    "• No refund will be issued, and redelivery may be charged extra.",
              ),

              _section(
                "7. Contact for Cancellations & Reschedules",
                "📧 Email: priya@gmail.com\n📞 Phone: +123232212",
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColor.black,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            content,
            style: GoogleFonts.roboto(
              color: AppColor.secondaryBlack,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
