import 'package:priya_fresh_meats/utils/exports.dart';
import 'package:priya_fresh_meats/views/profile/orders_history_view.dart';

class OrderDetailsView extends StatefulWidget {
  final String orderId;
  const OrderDetailsView({super.key, required this.orderId});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final orderprovider = Provider.of<OrderViewModel>(context, listen: false);
      await orderprovider.fetchOrderDetails(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: GoogleFonts.roboto(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: colorScheme.onPrimary,
        centerTitle: true,
        surfaceTintColor: colorScheme.onPrimary,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: _buildBottomButtons(colorScheme),
      ),
      backgroundColor: const Color.fromARGB(255, 239, 242, 243),
      body: Consumer<OrderViewModel>(
        builder: (context, provider, _) {
          if (provider.isOrderDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          final order = provider.orderDetailsdata;
          if (order.items.isEmpty) {
            return Center(
              child: Text(
                "No Order Details Found",
                style: GoogleFonts.roboto(fontSize: 16.sp),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: ListView(
              children: [
                SizedBox(height: 10.h),

                _buildCard(
                  context,
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5).r,
                        height: 45.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 239, 242, 243),
                          border: Border.all(
                            color: AppColor.dividergrey,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(100).r,
                        ),
                        child: Image.asset("assets/images/package.png"),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        order.status,
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                _buildCard(
                  context,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeadingWithIcon(
                        context,
                        order.store.name,
                        "assets/images/logo.png",
                        order.store.address,
                      ),

                      Divider(thickness: 0.7, color: Colors.grey[300]),
                      ...order.items.map(
                        (item) =>
                            _buildItemRow(item.name, item.quantity, item.price),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                _buildCard(
                  context,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeadingwithIcons(
                        context,
                        'Bill Details',
                        null,
                        iconData: Icons.receipt_long,
                      ),
                      SizedBox(height: 5.h),
                      Divider(height: 1.h, color: Colors.grey[300]),
                      SizedBox(height: 10.h),
                      _buildPriceRow('Item Total', order.billDetails.itemTotal),
                      _buildPriceRow(
                        'Delivery Charges',
                        order.billDetails.deliveryCharges,
                      ),
                      _buildPriceRow('Discount', -order.billDetails.discount),
                      Divider(height: 1.h, color: Colors.grey[300]),
                      _buildPriceRow(
                        'Grand Total',
                        order.billDetails.grandTotal,
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                _buildCard(
                  context,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeadingwithIcons(
                        context,
                        'Delivery Address',
                        null,
                        iconData: Icons.location_on_outlined,
                      ),
                      SizedBox(height: 5.h),
                      Divider(height: 1.h, color: Colors.grey[300]),
                      Text(
                        order.deliveryAddress.name,
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        order.deliveryAddress.location,
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        order.deliveryAddress.pincode,
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                _buildCard(
                  context,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeadingwithIcons(
                        context,
                        'Payment Method',
                        null,
                        iconData: Icons.account_balance_wallet_outlined,
                      ),
                      SizedBox(height: 5.h),
                      Divider(height: 1.h, color: Colors.grey[300]),
                      SizedBox(height: 5.h),
                      Text(
                        "N/A",
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomButtons(ColorScheme colorScheme) {
    return Consumer<OrderViewModel>(
      builder: (context, orderProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -2),
                blurRadius: 10,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.red, width: 1),
                    foregroundColor: Colors.red,
                    backgroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.roboto(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      orderProvider.isReOrdering
                          ? null
                          : () async {
                            await orderProvider.reorderfromHistory(
                              context,
                              widget.orderId,
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: colorScheme.onPrimary,
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                  ),
                  child:
                      orderProvider.isReOrdering
                          ? SizedBox(
                            height: 10.h,
                            width: 10.w,
                            child: CircularProgressIndicator(
                              color: colorScheme.onPrimary,
                            ),
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.arrowRotateLeft,
                                size: 16.sp,
                                color: colorScheme.onPrimary,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Reorder',
                                style: GoogleFonts.roboto(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildCard(BuildContext context, Widget child) {
  final colorScheme = Theme.of(context).colorScheme;
  return Container(
    padding: EdgeInsets.all(20).r,
    decoration: BoxDecoration(
      color: colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(15).r,
    ),
    child: child,
  );
}

Widget _buildItemRow(String name, int qty, int price) {
  return Padding(
    padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 10.w).r,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const NonVegSymbol(),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            '$name x$qty',
            style: GoogleFonts.roboto(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.secondaryBlack,
            ),
          ),
        ),
        Text(
          '\u{20B9}${price * qty}',
          style: GoogleFonts.roboto(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPriceRow(String label, int amount, {bool isTotal = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: isTotal ? 16.sp : 15.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        Text(
          (amount < 0 ? '- ' : '') + '\u{20B9}${amount.abs()}',
          style: GoogleFonts.roboto(
            fontSize: isTotal ? 16.sp : 15.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isTotal ? Colors.black : null,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeadingWithIcon(
  BuildContext context,
  String title,
  String imagePath, [
  String? subtitle,
]) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(5).r,
        height: 45.h,
        width: 50.w,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 242, 243),
          border: Border.all(color: AppColor.dividergrey, width: 0.5),
          borderRadius: BorderRadius.circular(100).r,
        ),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
      SizedBox(width: 10.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: GoogleFonts.roboto(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    ],
  );
}

Widget _buildSectionHeadingwithIcons(
  BuildContext context,
  String title,
  String? imagePath, {
  String? subtitle,
  IconData? iconData,
}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(5).r,
        height: 38.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 242, 243),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(100).r,
        ),
        child:
            iconData != null
                ? Icon(iconData, size: 24.sp, color: Colors.black54)
                : imagePath != null
                ? Image.asset(imagePath)
                : null,
      ),
      SizedBox(width: 10.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: GoogleFonts.roboto(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    ],
  );
}
