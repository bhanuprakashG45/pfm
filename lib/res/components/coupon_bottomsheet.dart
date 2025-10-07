import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priya_fresh_meats/data/models/cart/allcoupons_model.dart';
import 'package:priya_fresh_meats/res/constents/colors.dart';
import 'package:priya_fresh_meats/viewmodels/cart_vm/cart_view_model.dart';
import 'package:provider/provider.dart';

class CouponScreen extends StatefulWidget {
  final ColorScheme colorScheme;

  const CouponScreen({super.key, required this.colorScheme});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Coupon> filteredCoupons = [];

  @override
  void initState() {
    super.initState();

    final cartProvider = context.read<CartProvider>();
    filteredCoupons = List.from(cartProvider.couponData.availableCoupons);

    _controller.addListener(() {
      final query = _controller.text.trim().toLowerCase();
      final cartProvider = context.read<CartProvider>();

      setState(() {
        if (query.isEmpty) {
          filteredCoupons = List.from(cartProvider.couponData.availableCoupons);
        } else {
          filteredCoupons =
              cartProvider.couponData.availableCoupons.where((coupon) {
                return coupon.code.toLowerCase().contains(query);
              }).toList();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _applyCoupon() {
  //   final code = _controller.text.trim();
  //   if (code.isNotEmpty) {
  //     context.read<CartProvider>().applyCoupon(code);
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Apply Coupon",
              style: GoogleFonts.roboto(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: widget.colorScheme.onPrimary,
            foregroundColor: AppColor.primaryBlack,
            shadowColor: widget.colorScheme.onPrimary,
            elevation: 0.1,
            surfaceTintColor: widget.colorScheme.onPrimary,
          ),
          backgroundColor: widget.colorScheme.onPrimary,
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _CouponInputField(
                  controller: _controller,
                  colorScheme: widget.colorScheme,
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child:
                      cartProvider.isCouponsLoading
                          ? const Center(child: CircularProgressIndicator())
                          : cartProvider.couponData.availableCoupons.isEmpty
                          ? Center(
                            child: Text(
                              "No Coupons Available",
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : _CouponList(
                            coupons: filteredCoupons,
                            userCoupons: cartProvider.couponData.userCoupons,
                            cartProvider: cartProvider,
                            colorScheme: widget.colorScheme,
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CouponInputField extends StatelessWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;

  const _CouponInputField({
    required this.controller,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter Coupon Code',
          hintStyle: GoogleFonts.roboto(
            color: Colors.grey.shade500,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }
}

class _CouponList extends StatelessWidget {
  final List<Coupon> coupons;
  final List<Coupon> userCoupons;
  final CartProvider cartProvider;
  final ColorScheme colorScheme;

  const _CouponList({
    required this.coupons,
    required this.userCoupons,
    required this.cartProvider,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: coupons.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final coupon = coupons[index];
        final isApplied = cartProvider.appliedCoupon == coupon.code;
        final isClaimed = userCoupons.any((uc) => uc.code == coupon.code);

        return GestureDetector(
          onTap: () {
            if (!isClaimed && !isApplied) {
              cartProvider.applyCoupon(coupon.code);
              Navigator.pop(context);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isApplied ? Colors.green : Colors.grey.shade300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.r),
              color: isApplied ? Colors.green.shade50 : Colors.transparent,
            ),
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isApplied ? Colors.green : Colors.transparent,
                    border: Border.all(
                      color: isApplied ? Colors.green : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child:
                      isApplied
                          ? Icon(Icons.check, color: Colors.white, size: 12.sp)
                          : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${coupon.discount}% OFF",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        coupon.name,
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          isClaimed ? "Claimed" : coupon.code,
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isClaimed && !isApplied)
                  ElevatedButton(
                    onPressed: () {
                      cartProvider.applyCoupon(coupon.code);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.onPrimary,
                      foregroundColor: colorScheme.primary,

                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: Text(
                      'Apply',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
