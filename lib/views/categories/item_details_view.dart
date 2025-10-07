import 'package:priya_fresh_meats/res/components/login_bottomsheet.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class ItemDetailsView extends StatefulWidget {
  final String itemId;
  const ItemDetailsView({super.key, required this.itemId});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  String userId = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pref = SharedPref();
      userId = await pref.getUserId();
      if (mounted) {
        context.read<ItemDetailsProvider>().fetchItemDetails(widget.itemId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            InkWell(
              onTap: () {
                userId.isEmpty
                    ? showLoginBottomSheet(
                      context,
                      message: "Please login to access your cart",
                    )
                    : Navigator.pushNamed(context, AppRoutes.cartView);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.0.h),
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout,
                      size: 30.sp,
                      color: colorScheme.tertiary,
                    ),
                    Text(
                      "Cart",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          actionsPadding: EdgeInsets.only(right: 20.w),
          backgroundColor: colorScheme.onPrimary,
          surfaceTintColor: colorScheme.onPrimary,
        ),
        backgroundColor: colorScheme.onPrimary,
        body: Consumer<ItemDetailsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              );
            }

            if (provider.errorMessage.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                    SizedBox(height: 16.h),
                    Text(
                      'Error Loading Item',
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Text(
                        provider.errorMessage,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: () {
                        // Future.microtask(() {
                        //   if (mounted) {
                        //     provider.retryFetchItemDetails(widget.itemId);
                        //   }
                        // });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final itemDetails = provider.itemDetails;
            if (itemDetails == null) {
              return Center(
                child: Text(
                  'No item details available',
                  style: GoogleFonts.roboto(fontSize: 16.sp),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 280.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child:
                                itemDetails.img.isNotEmpty
                                    ? CachedNetworkImage(
                                      imageUrl: itemDetails.img,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (context, url) => Center(
                                            child: SizedBox(
                                              width: 25.w,
                                              height: 25.h,
                                              child:
                                                  const CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                            ),
                                          ),
                                      errorWidget:
                                          (context, url, error) => Container(
                                            color: Colors.grey.shade300,
                                            child: Icon(
                                              Icons.broken_image,
                                              color: Colors.grey.shade600,
                                              size: 40.sp,
                                            ),
                                          ),
                                    )
                                    : Container(
                                      color: Colors.grey.shade200,
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey.shade500,
                                        size: 40.sp,
                                      ),
                                    ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.h),
                              Text(
                                itemDetails.name,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "${itemDetails.typeString} | ${itemDetails.quality}",
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_border_rounded,
                                    color: Colors.orange,
                                    size: 25.sp,
                                  ),
                                  Text(
                                    "Desi Cuts premium quality",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.primary,
                                    ),
                                    overflow: TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.h,
                                  horizontal: 15.w,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    240,
                                    240,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.scaleBalanced,
                                      color: AppColor.secondaryBlack,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 7.w),
                                    Text(
                                      itemDetails.weight,
                                      style: GoogleFonts.roboto(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black,
                                      ),
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "  |  ",
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.utensils,
                                      color: AppColor.secondaryBlack,
                                      size: 15.sp,
                                    ),
                                    SizedBox(width: 7.w),
                                    Flexible(
                                      child: Text(
                                        itemDetails.pieces,
                                        style: GoogleFonts.roboto(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Text(
                                      "  |  ",
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.users,
                                      color: AppColor.secondaryBlack,
                                      size: 15.sp,
                                    ),
                                    SizedBox(width: 7.w),
                                    Text(
                                      itemDetails.servesText,
                                      style: GoogleFonts.roboto(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black,
                                      ),
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              // Description
                              Text(
                                itemDetails.description,
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.secondaryBlack,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                'Nutritional information: (Approx values per 100g)',
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primaryBlackshade,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              _buildNutritionalInfo(
                                'Total Energy',
                                '${itemDetails.totalEnergy} kcal',
                              ),
                              _buildNutritionalInfo(
                                'Carbohydrate',
                                '${itemDetails.carbohydrate} g',
                              ),
                              _buildNutritionalInfo(
                                'Fat',
                                '${itemDetails.fat} g',
                              ),
                              _buildNutritionalInfo(
                                'Protein',
                                '${itemDetails.protein} g',
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20).r,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.dividergrey,
                        offset: Offset(0, -2),
                        blurRadius: 0.5,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius:
                        BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ).r,
                  ),
                  child: Row(
                    children: [
                      // Price Section
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(12).r,
                        ),
                        child: Text(
                          "\u{20B9}${itemDetails.discountedPrice.toStringAsFixed(0)}",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Row(
                        children: [
                          Text(
                            "\u{20B9}${itemDetails.originalPrice.toStringAsFixed(0)}",
                            style: GoogleFonts.roboto(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "${itemDetails.discountPercentage}% OFF",
                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Consumer<HomeViewmodel>(
                        builder: (context, provider, child) {
                          return AddToCartButton(
                            itemId: itemDetails.id,
                            initialCount: 0,
                            onChanged: (count) async {
                              await provider.fetchCartCount();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNutritionalInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Text(
        '$label: $value',
        style: GoogleFonts.roboto(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.secondaryBlack,
        ),
      ),
    );
  }
}
