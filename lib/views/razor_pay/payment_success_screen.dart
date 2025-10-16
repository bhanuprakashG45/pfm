import 'package:priya_fresh_meats/utils/exports.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final homescreenprovider = Provider.of<HomeViewmodel>(
        context,
        listen: false,
      );
      final SharedPref _pref = SharedPref();
      String couponId = await _pref.getCouponId();
      int walletAmount = await _pref.getWalletAmount();
      final cartprovider = Provider.of<CartProvider>(context, listen: false);
      await cartprovider.placeOrder(context, couponId, walletAmount);
      await cartprovider.fetchCartItems();
      await homescreenprovider.fetchBestSellers();
      await homescreenprovider.fetchCartCount();
      debugPrint("CouponId : $couponId");
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return Skeletonizer(
            enabled: value.isOrderPlacing,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Payment Successful!',
                    style: GoogleFonts.roboto(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorscheme.primary,
                    ),
                    onPressed:
                        value.isOrderPlacing
                            ? null
                            : () {
                              debugPrint('Placed Order Id :${value.orderID}');
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.trackordersView,
                                arguments: value.orderID,
                              );
                            },

                    child:
                        value.isOrderPlacing
                            ? SizedBox(
                              height: 10.h,
                              width: 10.w,
                              child: CircularProgressIndicator(
                                color: colorscheme.onPrimary,
                                strokeWidth: 2.0.w,
                              ),
                            )
                            : Text(
                              'Click Here to Track Your Order',
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                color: colorscheme.onPrimary,
                                fontWeight: FontWeight.w500,
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
