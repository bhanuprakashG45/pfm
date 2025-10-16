import 'package:priya_fresh_meats/utils/exports.dart';
import 'package:priya_fresh_meats/viewmodels/razorpay_vm/razorpay_viewmodel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String address = '';
  String? orderId;

  Razorpay _razorpay = Razorpay();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _houseFloorController = TextEditingController();

  String _selectedDeliveryType = "Self";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final cartprovider = Provider.of<CartProvider>(context, listen: false);
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      final SharedPref _pref = SharedPref();
      address = await _pref.getUserAddress();
      await cartprovider.fetchCartItems();
      await cartprovider.fetchAllCoupons();
      await cartprovider.fetchWallet();
      await _pref.clearWalletAmount();
      await _pref.clearCouponId();
    });
  }

  void openCheckout(double price) async {
    final provider = Provider.of<RazorpayViewmodel>(context, listen: false);
    final profilevm = Provider.of<ProfileViewModel>(context, listen: false);
    final cartvm = Provider.of<CartProvider>(context, listen: false);
    final locationprovider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );

    cartvm.totalAmount < 500 ? cartvm.setSwitchwallet(false) : null;
    debugPrint(
      "${_nameController.text}${_mobileController.text}${_houseFloorController.text}",
    );
    if (_nameController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        _houseFloorController.text.isEmpty) {
      customErrorToast(context, "Please fill Delivery details");
      return;
    }
    if (_mobileController.text.length < 10) {
      customErrorToast(context, "Please enter valid mobile number");
      return;
    }

    await locationprovider.storeUserDetails(
      _houseFloorController.text,
      _houseFloorController.text,
      _mobileController.text,
    );

    await provider.initpayment(price);
    orderId = provider.razorpayOrderId;

    var options = {
      'key': AppUrls.keyId,
      'amount': (price * 100).round(),
      "currency": "INR",
      'name': 'Priya Fresh Meats',
      'description': 'Order Payment',
      "order_id": orderId,
      'prefill': {
        'contact': profilevm.profiledata.phone,
        'name': profilevm.profiledata.name,
      },
      'external': {
        'wallets': ['paytm'],
      },
      "timeout": 200,
    };

    try {
      _razorpay.open(options);
      print("Options :$options");
    } catch (e) {
      customErrorToast(context, " $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    debugPrint('OrderId:${response.orderId}');
    debugPrint("PaymentId:${response.paymentId}");
    debugPrint("Signature:${response.signature}");
    customSuccessToast(context, "Payment Successful: ${response.paymentId}");
    debugPrint("Payment response body : ${response.data}");
    final razorpayprovider = Provider.of<RazorpayViewmodel>(
      context,
      listen: false,
    );
    await _prefs.setBool("pending_order", true);
    debugPrint("Pending order set to true: ${_prefs.getBool("pending_order")}");
    try {
      await razorpayprovider.verifyPayment(
        context: context,
        razorpayOrderId: razorpayprovider.razorpayOrderId ?? "",
        razorpayPaymentId: response.paymentId ?? "",
        razorpaySignature: response.signature ?? "",
        onSucess: () async {
          final SharedPref _pref = SharedPref();

          String couponId = await _pref.getCouponId();
          int walletAmount = await _pref.getWalletAmount();

          final cartprovider = Provider.of<CartProvider>(
            context,
            listen: false,
          );
          final homescreenprovider = Provider.of<HomeViewmodel>(
            context,
            listen: false,
          );

          await cartprovider.placeOrder(context, couponId, walletAmount);
          cartprovider.cartItemsData.clear();
          homescreenprovider.clearCartCount();
          Navigator.pushReplacementNamed(context, AppRoutes.activeOrders);
          await homescreenprovider.fetchBestSellers();
        },
      );
    } catch (e) {
      debugPrint("Error in payment success handler: $e");
      customErrorToast(
        context,
        "Something went wrong after payment!Call for support.",
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    customErrorToast(context, "Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    customSuccessToast(context, "Payment Failure: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    final theme = MaterialTheme();
    final colorScheme = Theme.of(context).colorScheme;
    final homeprovider = Provider.of<HomeViewmodel>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Consumer2<CartProvider, LocationProvider>(
      builder: (context, cartProvider, locationprovider, child) {
        return SafeArea(
          top: false,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Cart",
                style: GoogleFonts.roboto(
                  color: AppColor.primaryBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp,
                ),
              ),
              backgroundColor: colorScheme.onPrimary,
              surfaceTintColor: colorScheme.onPrimary,
              shadowColor: AppColor.white,
              elevation: 0.1,
            ),
            backgroundColor: AppColor.offWhite,
            bottomNavigationBar:
                cartProvider.cartItemsData.isEmpty
                    ? const SizedBox()
                    : Container(
                      padding: EdgeInsets.only(bottom: 8.r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildBottomButton(
                            context,
                            theme,
                            colorScheme,
                            cartProvider,
                          ),
                        ],
                      ),
                    ),

            body:
                cartProvider.isCartFetching ||
                        cartProvider.isAmountLoading ||
                        cartProvider.isCouponsLoading
                    ? Container(
                      color: Colors.transparent,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: colorScheme.primary,
                        ),
                      ),
                    )
                    : cartProvider.cartItemsData.isEmpty
                    ? Center(
                      child: Image.asset(
                        'assets/images/no_orders.png',
                        width: size.width * 0.8,
                        height: size.height * 0.4,
                        fit: BoxFit.contain,
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.only(bottom: 10.h),
                      itemCount: cartProvider.cartItemsData.length + 2,
                      itemBuilder: (context, index) {
                        if (index < cartProvider.cartItemsData.length) {
                          final item = cartProvider.cartItemsData[index];
                          return Container(
                            color: colorScheme.onPrimary,
                            padding: EdgeInsets.all(15.dg),
                            child: Card(
                              elevation: 0.3,
                              color: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                                side: BorderSide(
                                  color: colorScheme.outlineVariant.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(13.dg),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 90.h,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: item.subCategory.img,
                                          fit: BoxFit.cover,
                                          placeholder:
                                              (context, url) => Container(
                                                color: Colors.grey.shade300,
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(Icons.error),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.subCategory.name,
                                            style: GoogleFonts.roboto(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            item.subCategory.description,
                                            style: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              color: AppColor.secondaryBlack,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            item.subCategory.weight,
                                            style: GoogleFonts.roboto(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '\u{20B9}${(item.subCategory.price * item.count).toStringAsFixed(2)}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 14.sp,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
                                              ),
                                            ),

                                            SizedBox(width: 8.w),

                                            Text(
                                              '\u{20B9}${(item.subCategory.discountPrice * item.count).toStringAsFixed(2)}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 15.sp,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),

                                        CounterButton(
                                          itemId: item.subCategory.id,
                                          initialCount: item.count,
                                          onChanged: (count) async {
                                            await homeprovider.fetchCartCount();
                                            await cartProvider.fetchCartItems();
                                            cartProvider.totalAmount;
                                            await homeprovider
                                                .fetchBestSellers();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        if (index == cartProvider.cartItemsData.length) {
                          return Column(
                            children: [
                              SizedBox(height: 20.h),
                              _buildOffersSection(context, theme, colorScheme),
                            ],
                          );
                        }
                        if (index == cartProvider.cartItemsData.length + 1) {
                          return Column(
                            children: [
                              SizedBox(height: 20.h),
                              _buildBillSummary(
                                theme,
                                colorScheme,
                                cartProvider,
                              ),

                              SizedBox(height: 20.h),
                              _buildDeliverySection(colorScheme),
                            ],
                          );
                        }

                        return SizedBox.shrink();
                      },
                    ),
          ),
        );
      },
    );
  }

  Widget _buildDeliverySection(ColorScheme colorScheme) {
    return Consumer2<LocationProvider, ProfileViewModel>(
      builder: (context, provider, profileprovider, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _nameController.text =
              provider.userName != null
                  ? provider.userName!
                  : profileprovider.profiledata.name;
          _mobileController.text =
              provider.userPhone != null
                  ? provider.userPhone!
                  : profileprovider.profiledata.phone;
          _houseFloorController.text = provider.userFloor ?? '';
        });

        return Container(
          color: colorScheme.onPrimary,
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Delivery Details',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(child: Divider(endIndent: 30.w, thickness: 0.5)),
                ],
              ),
              SizedBox(height: 15.h),

              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.w),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        "Self",
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: "Self",
                      groupValue: _selectedDeliveryType,
                      activeColor: colorScheme.primary,
                      onChanged: (value) {
                        setState(() {
                          _selectedDeliveryType = value!;
                          provider.userType = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        "other",
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: "other",
                      groupValue: _selectedDeliveryType,
                      activeColor: colorScheme.primary,
                      onChanged: (value) {
                        setState(() {
                          _selectedDeliveryType = value!;
                          provider.userType = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),
              TextField(
                controller: _nameController,
                onChanged: (value) {
                  provider.userName = value;
                },
                decoration: InputDecoration(
                  labelText: "Reciever Name *",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 12.w,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              TextField(
                controller: _mobileController,
                onChanged: (value) {
                  provider.userPhone = value;
                },
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: "Reciever Mobile Number *",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 12.w,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: _houseFloorController,
                onChanged: (value) {
                  provider.userFloor = value;
                },
                decoration: InputDecoration(
                  labelText: "House No. / Floor *",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 12.w,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              if (address.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 5.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: colorScheme.primary),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          provider.fullAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.addressBook);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 6.w,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            "Change",
                            style: GoogleFonts.roboto(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomButton(
    BuildContext context,
    MaterialTheme theme,
    ColorScheme colorScheme,
    CartProvider cartProvider,
  ) {
    final totalprovider = Provider.of<CartProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(8.dg),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10).r,
            backgroundColor: colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: () async {
            final total = totalprovider.totalAmount;
            debugPrint(total.toString());
            openCheckout(total);
          },
          child:
              totalprovider.isAmountLoading
                  ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      color: colorScheme.onPrimary,
                      strokeWidth: 2.0.w,
                    ),
                  )
                  : Text(
                    "Click here to Pay",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildOffersSection(
    BuildContext context,
    MaterialTheme theme,
    ColorScheme colorScheme,
  ) {
    return Consumer<CartProvider>(
      builder: (context, cartprovider, child) {
        return Container(
          color: colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(),
              SizedBox(height: 20.h),

              _buildCouponCard(context, theme, colorScheme, cartprovider),
              SizedBox(height: 16.h),
              Column(
                children: [
                  if (cartprovider.totalAmount > 550) ...[
                    _buildWalletCard(cartprovider),
                    SizedBox(height: 16.h),
                  ],
                ],
              ),
              SizedBox(height: 10.h),
              _buildBenefitsCard(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade50, Colors.green.shade100],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.green.shade200, width: 1),
          ),
          child: Text(
            'Offers & Benefits',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: Colors.green.shade800,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade200, Colors.transparent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCouponCard(
    BuildContext context,
    MaterialTheme theme,
    ColorScheme colorScheme,
    CartProvider cartProvider,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => CouponScreen(colorScheme: Theme.of(context).colorScheme),
          ),
        ).then((selectedCoupon) {
          if (selectedCoupon != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<CartProvider>().setSwitchwallet(false);
              context.read<CartProvider>().applyCoupon(selectedCoupon);
            });
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.green.shade200, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade100.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Lottie.asset(
                  "assets/json/Offer.json",
                  height: 32.h,
                  width: 32.w,
                  repeat: true,
                ),
              ),
              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Apply Coupon Code",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Get amazing discounts on your order",
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.green.shade700,
                  size: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletCard(CartProvider cartProvider) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.greenGrad1.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.greenGrad1.withValues(alpha: 0.1),
                    AppColor.greenGrad1.withValues(alpha: 0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(
                "assets/images/crypto-wallet.png",
                height: 28.h,
                width: 28.w,
              ),
            ),
            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wallet Balance",
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "₹ ${cartProvider.walletAmount.walletPoints}",
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.greenGrad1,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color:
                    (cartProvider.isSwitchOn ?? false)
                        ? AppColor.greenGrad1.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: cartProvider.isSwitchOn ?? false,
                  onChanged: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (value) {
                        cartProvider.applyCoupon(null);
                      }

                      cartProvider.setSwitchwallet(value);

                      if (!value && cartProvider.appliedCoupon != null) {
                        cartProvider.applyCoupon(cartProvider.appliedCoupon);
                      }
                    });
                  },
                  activeColor: AppColor.greenGrad1,
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.withValues(alpha: 0.2),
                  activeTrackColor: AppColor.greenGrad1.withValues(alpha: 0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.orange.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.orange.shade200, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(
              Icons.local_offer_rounded,
              color: Colors.orange.shade700,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special Benefits",
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Free delivery • Cashback rewards • Priority support",
                    style: GoogleFonts.roboto(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "Active",
                style: GoogleFonts.roboto(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillSummary(
    MaterialTheme theme,
    ColorScheme colorScheme,
    CartProvider cartProvider,
  ) {
    final SharedPref _pref = SharedPref();

    final itemTotal = cartProvider.cartItemsData.fold<double>(
      0,
      (sum, item) => sum + (item.subCategory.discountPrice * item.count),
    );

    const double deliveryFee = 39.0;
    const double handlingFee = 5.0;
    double discount = 0.0;
    double walletUsed = 0.0;

    final appliedCode = cartProvider.appliedCoupon;
    final walletEnabled = cartProvider.isSwitchOn ?? false;
    final walletBalance = cartProvider.walletAmount.walletPoints.toDouble();

    if (appliedCode != null && appliedCode.isNotEmpty && walletEnabled) {
      cartProvider.setSwitchwallet(false);
    }
    if (appliedCode != null && appliedCode.isNotEmpty && !walletEnabled) {
      final coupon = cartProvider.couponData.availableCoupons.firstWhere(
        (c) => c.code.toLowerCase() == appliedCode.toLowerCase(),
        orElse:
            () => Coupon(
              id: '',
              name: '',
              code: '',
              discount: 0,
              expiryDate: DateTime.now(),
              limit: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              v: 0,
            ),
      );

      if (coupon.code.isNotEmpty) {
        debugPrint("Entered into Coupon");
        _pref.storeCouponId(coupon.id);

        if (coupon.code.toLowerCase() == 'freeship') {
          discount = deliveryFee;
        } else {
          discount = itemTotal * (coupon.discount / 100);
        }
      }
    }
    double totalBeforeWallet = itemTotal + deliveryFee + handlingFee - discount;

    if (walletEnabled) {
      walletUsed =
          walletBalance >= totalBeforeWallet
              ? totalBeforeWallet
              : walletBalance;
    }

    final total = totalBeforeWallet - walletUsed;

    return Container(
      color: colorScheme.onPrimary,
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bill Summary',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(child: Divider(endIndent: 30.w, thickness: 0.5)),
            ],
          ),
          SizedBox(height: 10.h),
          _buildBillRow(
            theme,
            'Item total',
            '\u{20B9}${itemTotal.toStringAsFixed(0)}',
          ),
          SizedBox(height: 10.h),
          _buildBillRow(
            theme,
            'Delivery Fee',
            '\u{20B9}${deliveryFee.toStringAsFixed(0)}',
          ),
          SizedBox(height: 10.h),
          _buildBillRow(
            theme,
            'Handling Fee',
            '\u{20B9}${handlingFee.toStringAsFixed(0)}',
          ),
          if (discount > 0)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: _buildBillRow(
                theme,
                'Discount (${appliedCode})',
                '-\u{20B9}${discount.toStringAsFixed(0)}',
              ),
            ),
          if (walletUsed > 0)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: _buildBillRow(
                theme,
                'Wallet used',
                '-\u{20B9}${walletUsed.toStringAsFixed(0)}',
              ),
            ),
          SizedBox(height: 10.h),
          Divider(thickness: 0.5),
          _buildBillRow(
            theme,
            'Amount to be paid',
            '\u{20B9}${total.toStringAsFixed(0)}',
            isBold: true,
            fontSize: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(
    MaterialTheme theme,
    String label,
    String value, {
    bool isBold = false,
    double? fontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
