import 'package:priya_fresh_meats/utils/exports.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<FaqItem> faqs = [
    FaqItem(
      question: 'What is PFM?',
      answer:
          'PFM is an online platform for ordering fresh meat, seafood, and ready-to-cook products delivered to your doorstep.',
    ),
    FaqItem(
      question: 'How is the meat packaged?',
      answer:
          'Our meat is hygienically vacuum-packed and delivered in temperature-controlled boxes to ensure freshness.',
    ),
    FaqItem(
      question: 'Do you deliver to my location?',
      answer:
          'We currently deliver to selected cities. Enter your pin code during checkout to see availability.',
    ),
    FaqItem(
      question: 'What are your delivery hours?',
      answer:
          'We deliver between 10 AM and 9 PM. You can choose your preferred time slot at checkout.',
    ),
    FaqItem(
      question: 'Is there a return policy?',
      answer:
          'Yes, if the product is damaged or not fresh, contact support within 2 hours for a replacement or refund.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAQs",
          style: GoogleFonts.roboto(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.onPrimary,
        shadowColor: colorscheme.onPrimary,
        elevation: 0.01,
      ),
      backgroundColor: colorscheme.onPrimary,
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final item = faqs[index];

          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.dividergrey,
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  item.question,
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.primaryBlack,
                  ),
                ),
                tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                collapsedIconColor: theme.primaryColor,
                iconColor: theme.primaryColor,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: Text(
                      item.answer,
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondaryBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}
