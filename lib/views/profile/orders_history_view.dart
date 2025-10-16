import 'package:intl/intl.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class OrdersHistoryView extends StatefulWidget {
  const OrdersHistoryView({super.key});

  @override
  State<OrdersHistoryView> createState() => _OrdersHistoryViewState();
}

class _OrdersHistoryViewState extends State<OrdersHistoryView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<OrderViewModel>(context, listen: false);
      await provider.fetchOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Order History'),
      backgroundColor: colorScheme.onPrimary,
      body: SafeArea(
        top: false,
        child: Consumer<OrderViewModel>(
          builder: (context, provider, _) {
            if (provider.isOrderHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final orders = provider.orderHistoryData;

            if (orders.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.noOrders, height: 280.h),
                    SizedBox(height: 16.h),
                    Text(
                      'No orders to display. Browse our products to place your first order!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.bottomNavBar,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 24.w,
                        ),
                      ),
                      child: Text(
                        'Explore Products',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: orders.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final order = orders[index];

                return Skeletonizer(
                  enabled:
                      provider.isOrderDeleting ||
                      provider.isOrderHistoryLoading,
                  child: OrderCard(
                    order: order,
                    onReorder: () {
                      customSuccessToast(context, "Order placed successfully");
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.onReorder});

  final OrderHistory order;
  final VoidCallback onReorder;

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat("dd MMM yyyy, hh:mm a").format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer2<OrderViewModel, HomeViewmodel>(
      builder: (context, orderprovider, homeprovider, child) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(12).r,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        order.items.isNotEmpty ? order.items[0].image : "",
                        height: 60.h,
                        width: 60.w,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Image.asset(
                              AppImages.noOrders,
                              height: 60.h,
                              width: 60.w,
                            ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.store.name,

                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            order.store.address,
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.secondaryBlack,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      color: colorScheme.onPrimary,
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) async {
                        if (value == 'order_history') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      OrderDetailsView(orderId: order.orderId),
                            ),
                          );
                        }
                        if (value == 'delete_order') {
                          await orderprovider.deleteOrderHistory(
                            context,
                            order.orderId,
                          );
                        }
                      },
                      itemBuilder:
                          (_) => [
                            PopupMenuItem<String>(
                              value: 'order_history',
                              child: Row(
                                children: [
                                  Icon(Icons.history, size: 18.sp),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Order Details',
                                    style: GoogleFonts.roboto(fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete_order',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  orderprovider.isOrderDeleting
                                      ? SizedBox(
                                        height: 10.h,
                                        width: 10.w,
                                        child: CircularProgressIndicator(
                                          color: colorScheme.primary,
                                        ),
                                      )
                                      : Text(
                                        'Delete Order',
                                        style: GoogleFonts.roboto(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ],
                    ),
                  ],
                ),
              ),

              Divider(color: AppColor.dividergrey, thickness: 0.5),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
                child: Column(
                  children: List.generate(order.items.length, (i) {
                    final item = order.items[i];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: i == order.items.length - 1 ? 0 : 8.h,
                      ),
                      child: Row(
                        children: [
                          const NonVegSymbol(),
                          SizedBox(width: 10.w),
                          Text(
                            '${item.quantity}',
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'x',
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              item.name,
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              Divider(color: AppColor.dividergrey, thickness: 0.5),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order placed on ${_formatDate(order.timestamps.orderedAt)}',
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondaryBlack,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      order.timestamps.deliveredAt == "Delivered"
                          ? 'Delivered on ${_formatDate(order.timestamps.deliveredAt)}'
                          : 'Cancelled Order',
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            order.timestamps.deliveredAt == "Delivered"
                                ? AppColor.greenGrad1
                                : colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\u{20B9}${order.items.fold<int>(0, (sum, item) => sum + (item.price * item.quantity))}',
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ElevatedButton(
                          onPressed:
                              orderprovider.isReOrdering
                                  ? null
                                  : () async {
                                    await orderprovider.reorderfromHistory(
                                      context,
                                      order.orderId,
                                    );
                                    await homeprovider.fetchCartCount();
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.greenGrad1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 15.w,
                            ),
                          ),
                          child:
                              orderprovider.isReOrdering
                                  ? SizedBox(
                                    height: 10.h,
                                    width: 10.w,
                                    child: CircularProgressIndicator(
                                      color: colorScheme.onPrimary,
                                    ),
                                  )
                                  : Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.arrowRotateLeft,
                                        size: 14.sp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        'Reorder',
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                        ),
                      ],
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
}

class NonVegSymbol extends StatelessWidget {
  const NonVegSymbol({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15.w,
      height: 15.w,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF883432), width: 2),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: const CustomPaint(painter: _TrianglePainter()),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  const _TrianglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFF883432)
          ..style = PaintingStyle.fill;

    final path =
        Path()
          ..moveTo(size.width * 0.5, size.height * 0.22)
          ..lineTo(size.width * 0.18, size.height * 0.78)
          ..lineTo(size.width * 0.82, size.height * 0.78)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
