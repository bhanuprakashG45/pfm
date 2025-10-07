import 'package:priya_fresh_meats/utils/exports.dart';

class ViewCartBottomSheet extends StatelessWidget {
  final VoidCallback onTap;

  const ViewCartBottomSheet({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewmodel>(
      builder: (context, homeVm, _) {
        final itemCount = homeVm.cartCount.totalCount;
        final totalAmount = homeVm.cartCount.totalAmount;

        if (itemCount == 0) return const SizedBox.shrink();

        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 60.h),
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ).r,
                      color: const Color(0xFFFFCB61),
                    ),
                    child: Center(
                      child: Text(
                        "Order Now | Delivery in 120 mins",
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryBlackshade,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryBlack,
                      borderRadius:
                          BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ).r,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${itemCount} items | ₹${totalAmount.toStringAsFixed(2)}',

                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'View Cart',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
