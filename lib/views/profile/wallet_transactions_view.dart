import 'package:priya_fresh_meats/utils/exports.dart';

class WalletTransactionsView extends StatefulWidget {
  const WalletTransactionsView({super.key});

  @override
  State<WalletTransactionsView> createState() => _WalletTransactionsViewState();
}

class _WalletTransactionsViewState extends State<WalletTransactionsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final cartprovider = Provider.of<CartProvider>(context, listen: false);
      await cartprovider.fetchWallet();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(title: 'Wallet'),
      backgroundColor: colorScheme.onPrimary,
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          final walletItem = provider.walletAmount;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20).r,
                height: 240.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.dividergrey,
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/images/login_bg.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.r),
                    bottomRight: Radius.circular(28.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28).r,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(28).r,
                    ),

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total balance",
                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "₹ ${walletItem.walletPoints}",
                            style: GoogleFonts.roboto(
                              color: colorScheme.primary,
                              fontSize: 30.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Divider(thickness: 0.7, color: AppColor.dividergrey),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "PFM Cash",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "₹ ${walletItem.walletPoints}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Expirable cash:\u{20B9}0",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),

                              // SizedBox(
                              //   height: 60.h,
                              //   child: VerticalDivider(thickness: 1),
                              // ),

                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,

                              //   children: [
                              //     Text(
                              //       "PFM Cash+",
                              //       style: GoogleFonts.roboto(
                              //         fontSize: 16.sp,
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //     ),
                              //     Text(
                              //       "0",
                              //       style: GoogleFonts.roboto(
                              //         fontSize: 22.sp,
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //     ),
                              //     Text(
                              //       "Max usage:\u{20B9}0",
                              //       style: GoogleFonts.roboto(
                              //         fontSize: 12.sp,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Last 5 Transactions',
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.dividergrey,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20).r,
                    color: colorScheme.onPrimary,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 150.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.h,
                        vertical: 20.h,
                      ),
                      child: Center(
                        child: Text(
                          "No Transactions Yet",
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.dividergrey,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20).r,
                    color: colorScheme.onPrimary,
                  ),

                  child: SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.h,
                        vertical: 5.h,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.faqsview);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FAQs",
                              style: GoogleFonts.roboto(
                                color: AppColor.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, size: 20.sp),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
