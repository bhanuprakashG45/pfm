import 'package:intl/intl.dart';
import 'package:priya_fresh_meats/data/models/profile/orders/active_order_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class ActiveOrdersView extends StatefulWidget {
  const ActiveOrdersView({super.key});

  @override
  State<ActiveOrdersView> createState() => _ActiveOrdersViewState();
}

class _ActiveOrdersViewState extends State<ActiveOrdersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<OrderViewModel>(context, listen: false);
      await provider.fetchActiveOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(title: "Active Orders"),
        backgroundColor: colorScheme.onPrimary,
        body: Consumer<OrderViewModel>(
          builder: (context, provider, child) {
            final orders = provider.activeorderData;
      
            if (provider.isActiveOrderLoading) {
              return Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              );
            }
      
            if (orders.isEmpty) {
              return Center(
                child: Text(
                  "No active orders found.",
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              );
            }
      
            return ListView.builder(
              padding: EdgeInsets.all(12).r,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
      
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.trackordersView,
                      arguments: order.orderId,
                    );
                  },
                  child: Card(
                    color: colorScheme.onPrimary,
                    elevation: 5,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16).r,
                    ),
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12).r,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColor.greenGrad1, AppColor.greenGrad2],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16).r,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.store.name,
                                style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                order.store.address,
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
      
                        Padding(
                          padding: EdgeInsets.all(12).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children:
                                    order.items
                                        .map(
                                          (item) => _ActiveItemCard(item: item),
                                        )
                                        .toList(),
                              ),
      
                              const Divider(thickness: 0.8),
      
                              Row(
                                children: [
                                  Text(
                                    "Status: ",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    order.status,
                                    style: GoogleFonts.roboto(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor(order.status),
                                    ),
                                  ),
                                ],
                              ),
      
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Text(
                                    "Ordered on: ",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateFormat(
                                      "dd MMM yyyy, hh:mm a",
                                    ).format(order.timestamps.orderedAt),
                                    style: GoogleFonts.roboto(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
      
                              SizedBox(height: 8.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Note: ",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.greenGrad1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Click on Details for Full Tracking and Cancellation",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "completed":
      case "delivered":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}

class _ActiveItemCard extends StatelessWidget {
  final ActiveItem item;

  const _ActiveItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8).r,
            child: Image.network(
              item.image,
              height: 55.h,
              width: 55.w,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    height: 55.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8).r,
                    ),
                    child: const Icon(Icons.image_not_supported, size: 22),
                  ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "${item.name} x${item.quantity}",
              style: GoogleFonts.roboto(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            "₹${item.total}",
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.greenGrad1,
            ),
          ),
        ],
      ),
    );
  }
}
