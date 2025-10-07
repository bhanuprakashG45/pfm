import 'package:priya_fresh_meats/data/models/profile/orders/track_order_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;
  const TrackOrderScreen({super.key, required this.orderId});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final provider = Provider.of<OrderViewModel>(context, listen: false);
      await provider.fetchTrackOrder(widget.orderId);
    });
  }

  String selectedReason = '';

  int _getCurrentStep(Stages stages) {
    if (stages.delivered) return 3;
    if (stages.inTransit) return 2;
    if (stages.pickedUp) return 1;
    if (stages.accepted) return 0;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(title: "Track your order"),
        backgroundColor: colorScheme.onPrimary,
        bottomNavigationBar: Consumer<OrderViewModel>(
          builder: (context, orderProvider, child) {
            final orderData = orderProvider.trackorderdata;
            final currentStep = _getCurrentStep(orderData.stages);

            if (currentStep >= 1) {
              return const SizedBox.shrink();
            }

            String? selectedReason;

            return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: EdgeInsets.all(8).r,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<String>(
                        dropdownColor: colorScheme.onPrimary,
                        value: selectedReason,
                        hint: const Text("Select Reason"),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                        ),
                        items:
                            [
                              "Ordered by mistake",
                              "Address mismatched",
                              "Delivery taking too long",
                              "Other",
                            ].map((reason) {
                              return DropdownMenuItem(
                                value: reason,
                                child: Text(reason),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedReason = value;
                          });
                        },
                      ),

                      SizedBox(height: 10.h),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            backgroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed:
                              orderProvider.isOrderCancelling
                                  ? null
                                  : () async {
                                    if (selectedReason == null) {
                                      customErrorToast(
                                        context,
                                        "Please select a reason",
                                      );
                                      return;
                                    }

                                    await orderProvider.cancelOrder(
                                      context,
                                      orderData.orderId,
                                      selectedReason!,
                                    );
                                    await orderProvider.fetchActiveOrders();

                                    if (context.mounted) {
                                      customErrorToast(
                                        context,
                                        "You have cancelled your order",
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                          child:
                              orderProvider.isOrderCancelling ||
                                      orderProvider.isActiveOrderLoading
                                  ? SizedBox(
                                    height: 10.h,
                                    width: 10.w,
                                    child: CircularProgressIndicator(
                                      color: colorScheme.onPrimary,
                                      strokeWidth: 2.0.w,
                                    ),
                                  )
                                  : Text(
                                    "Cancel Order",
                                    style: GoogleFonts.roboto(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),

        body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Consumer<OrderViewModel>(
            builder: (context, orderProvider, child) {
              final orderData = orderProvider.trackorderdata;

              if (orderProvider.isTrackOrderFetching) {
                return const Center(child: CircularProgressIndicator());
              }

              if (orderData.orderId.isEmpty) {
                return const Center(child: Text("No order found"));
              }

              final displayOrder = orderData.displayOrder;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(15).r,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.dividergrey,
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            OrderTrackingWidget(
                              currentStep: _getCurrentStep(orderData.stages),
                              steps: [
                                TrackingStep("Order Placed"),
                                TrackingStep("Shipped"),
                                TrackingStep("Out for Delivery"),
                                TrackingStep("Delivered"),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              height: 180.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/track_bg.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(13.r),
                                  bottomRight: Radius.circular(13.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(15).r,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.dividergrey,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/crypto-wallet.png",
                                height: 35.h,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Amount Paid",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.greenGrad1,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 5.h,
                                  ),
                                  child: Text(
                                    "\u{20B9}${displayOrder.amount}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 15.sp,
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(15).r,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.dividergrey,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.red,
                                  size: 30.sp,
                                ),
                                SizedBox(width: 10.w),
                                Flexible(
                                  child: Text(
                                    "${displayOrder.location}, ${displayOrder.pincode}",
                                    overflow: TextOverflow.visible,
                                    maxLines: 3,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(15).r,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.dividergrey,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Details",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Divider(color: AppColor.dividergrey),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    displayOrder.orderDetails.map((item) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6.h,
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: CachedNetworkImage(
                                                imageUrl: item.img,
                                                scale: 1.0,
                                                height: 40.h,
                                                width: 40.w,
                                                fit: BoxFit.cover,
                                                placeholder:
                                                    (context, url) => SizedBox(
                                                      height: 40.h,
                                                      width: 40.w,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              strokeWidth: 2.w,
                                                            ),
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (
                                                      context,
                                                      url,
                                                      error,
                                                    ) => Container(
                                                      height: 40.h,
                                                      width: 40.w,
                                                      color:
                                                          Colors.grey.shade200,
                                                      child: Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        size: 20.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Text(
                                                " ${item.name} x ${item.quantity}",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              "\u{20B9}${item.price}",
                                              style: GoogleFonts.roboto(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.greenGrad1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
