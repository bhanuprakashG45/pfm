import 'dart:ui';
import 'package:priya_fresh_meats/utils/exports.dart';
import 'package:priya_fresh_meats/viewmodels/category_vm/category_viewmodel.dart';

class ItemsView extends StatefulWidget {
  final String categoryType;
  final String subcategoryId;

  const ItemsView({
    super.key,
    required this.categoryType,
    required this.subcategoryId,
  });

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<CategoryViewmodel>(context, listen: false);
      await provider.fetchSubCategoryItems(widget.subcategoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryType,
          style: GoogleFonts.roboto(
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: colorScheme.onPrimary,
        shadowColor: colorScheme.onPrimary,
        surfaceTintColor: colorScheme.onPrimary,
        elevation: 0.1,
      ),
      backgroundColor: colorScheme.onPrimary,
      body: Consumer<CategoryViewmodel>(
        builder: (context, itemProvider, child) {
          if (itemProvider.isItemsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (itemProvider.itemdata.isEmpty) {
            return const Center(child: Text("No items available"));
          }

          return SafeArea(
            top: false,
            child: Stack(
              children: [
                ListView.builder(
                  cacheExtent: 1000,
                  itemCount: itemProvider.itemdata.length + 1,
                  padding: EdgeInsets.all(10.w),
                  itemBuilder: (context, index) {
                    if (index == itemProvider.itemdata.length) {
                      return SizedBox(height: 200.h);
                    }

                    final item = itemProvider.itemdata[index];
                    final isAvailable = item.available;
                    final isNotify = item.notify;

                    return Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15.r),
                            ),
                            child: Stack(
                              children: [
                                (item.img.isEmpty)
                                    ? Container(
                                      height: 220.h,
                                      color: Colors.grey.shade200,
                                      child: Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 80.sp,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    )
                                    : ColorFiltered(
                                      colorFilter:
                                          isAvailable
                                              ? const ColorFilter.mode(
                                                Colors.transparent,
                                                BlendMode.multiply,
                                              )
                                              : const ColorFilter.mode(
                                                Colors.grey,
                                                BlendMode.saturation,
                                              ),
                                      child: CachedNetworkImage(
                                        imageUrl: item.img,
                                        width: double.infinity,
                                        height: 220.h,
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (context, url) => Center(
                                              child: CircularProgressIndicator(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                        errorWidget:
                                            (context, url, error) => Container(
                                              height: 220.h,
                                              color: Colors.grey.shade200,
                                              child: Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 80.sp,
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                            ),
                                      ),
                                    ),

                                if (!isAvailable)
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.r),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 6,
                                          sigmaY: 6,
                                        ),
                                        child: Container(
                                          height: 40.h,
                                          width: double.infinity,
                                          color: Colors.grey.withValues(
                                            alpha: 0.5,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "OUT OF STOCK",
                                            style: GoogleFonts.roboto(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700,
                                              color: colorScheme.onPrimary,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          Consumer<HomeViewmodel>(
                            builder: (context, homeProvider, _) {
                              final initialCount = 0;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 15.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      item.description,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: AppColor.secondaryBlack,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      '${item.weight} | ${item.pieces} pcs • Serves ${item.serves}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),

                                    Row(
                                      children: [
                                        Container(
                                          height: 15.h,
                                          width: 15.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.orange.shade300,
                                            borderRadius: BorderRadius.circular(
                                              50.r,
                                            ),
                                          ),
                                          child: FaIcon(
                                            FontAwesomeIcons.bolt,
                                            color: Colors.white,
                                            size: 10.sp,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          'Today in 120 mins',
                                          style: GoogleFonts.roboto(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.secondaryBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 10,
                                              ).r,
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade50,
                                            borderRadius:
                                                BorderRadius.circular(5).r,
                                          ),
                                          child: Text(
                                            "\u{20B9}${item.price}",
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.sp,
                                              color: AppColor.greenGrad1,
                                            ),
                                          ),
                                        ),

                                        isAvailable
                                            ? AddToCartButton(
                                              itemId: item.id,
                                              initialCount: initialCount,
                                              onChanged: (count) async {
                                                await homeProvider
                                                    .fetchCartCount();
                                              },
                                            )
                                            : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    colorScheme.onPrimary,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: AppColor.dividergrey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                ),
                                              ),
                                              onPressed:
                                                  isNotify
                                                      ? null
                                                      : () async {
                                                        await homeProvider
                                                            .notifyMe(item.id);
                                                        await itemProvider
                                                            .fetchSubCategoryItems(
                                                              widget
                                                                  .subcategoryId,
                                                            );
                                                      },
                                              child:
                                                  homeProvider.isNotifyMeLoading
                                                      ? SizedBox(
                                                        height: 10.h,
                                                        width: 10.w,
                                                        child:
                                                            CircularProgressIndicator(
                                                              color:
                                                                  colorScheme
                                                                      .primary,
                                                              strokeWidth:
                                                                  2.0.w,
                                                            ),
                                                      )
                                                      : Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            isNotify
                                                                ? "Notified"
                                                                : "Notify",
                                                            style: GoogleFonts.roboto(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  isNotify
                                                                      ? Colors
                                                                          .green
                                                                      : colorScheme
                                                                          .primary,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          Icon(
                                                            isNotify
                                                                ? Icons
                                                                    .check_circle
                                                                : Icons
                                                                    .notifications_active,
                                                            color:
                                                                isNotify
                                                                    ? Colors
                                                                        .green
                                                                    : colorScheme
                                                                        .primary,
                                                          ),
                                                        ],
                                                      ),
                                            ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                Positioned(
                  bottom: 0.h,
                  left: 0,
                  right: 0,
                  child: ViewCartBottomSheet(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.cartView);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
