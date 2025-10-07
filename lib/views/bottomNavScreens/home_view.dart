import 'package:priya_fresh_meats/res/components/login_bottomsheet.dart';
import 'package:priya_fresh_meats/res/components/rewards_card.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userId = "";
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pref = SharedPref();
      userId = await pref.getUserId();
      final homeProvider = Provider.of<HomeViewmodel>(context, listen: false);
      final shopbycategoryprovider = Provider.of<ShopbycategoryViewmodel>(
        context,
        listen: false,
      );
      final locationProvider = Provider.of<LocationProvider>(
        context,
        listen: false,
      );
      final orderprovider = Provider.of<OrderViewModel>(context, listen: false);
      await orderprovider.fetchActiveOrders();
      await homeProvider.fetchBestSellers();
      await homeProvider.fetchCartCount();
      await shopbycategoryprovider.fetchShopByCategory();
      if (!mounted) return;

      debugPrint('Loading saved location...');
      await locationProvider.loadSavedLocation();
      debugPrint('Saved location loaded: ${locationProvider.fullAddress}');

      if (!mounted) return;

      if (!locationProvider.hasLocation) {
        debugPrint(
          'Showing location bottom sheet because location is missing...',
        );
        _showLocationBottomSheet(context);
      }
    });
  }

  void _showLocationBottomSheet(BuildContext context) {
    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0).r),
        ),
        builder: (BuildContext context) {
          final colorscheme = Theme.of(context).colorScheme;
          return Consumer<LocationProvider>(
            builder: (context, provider, child) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  top: 20.h,
                  bottom: MediaQuery.of(context).padding.bottom + 20.h,
                ),
                decoration: BoxDecoration(
                  color: colorscheme.onPrimary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0).r,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "Where should we deliver your order? \n \n",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primaryBlack,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Enable location access to show available products for your area",
                                    style: GoogleFonts.roboto(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: colorscheme.outline,
                                    ),
                                  ),
                                ],
                              ),
                              softWrap: true,
                            ),
                          ),
                          SizedBox(
                            width: 90.w,
                            height: 120.h,
                            child: Lottie.asset(
                              "assets/json/location_map.json",
                              repeat: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ElevatedButton(
                        onPressed:
                            provider.isCurrentLocationLoading
                                ? null
                                : () async {
                                  // final error =
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                  await provider.fetchAndSaveCurrentLocation();
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: Size(double.infinity, 48.h),
                        ),
                        child:
                            provider.isCurrentLocationLoading
                                ? SizedBox(
                                  height: 15.h,
                                  width: 15.w,
                                  child: CircularProgressIndicator(
                                    color: colorscheme.onPrimary,
                                    strokeWidth: 2.0.w,
                                  ),
                                )
                                : Text(
                                  'Use Current Location',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.addressBook);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 48.h),
                        ),
                        child: Text(
                          'Add Location',
                          style: GoogleFonts.roboto(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 125, 10, 2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      debugPrint('Error showing bottom sheet: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        surfaceTintColor: colorScheme.onPrimary,
        toolbarHeight: 75.h,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<LocationProvider>(
                builder: (context, locationProvider, _) {
                  return locationProvider.isCurrentLocationLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                          strokeWidth: 2.0.w,
                        ),
                      )
                      : InkWell(
                        onTap: () {
                          userId.isEmpty
                              ? showLoginBottomSheet(
                                context,
                                message: "Please login to set your location",
                              )
                              : Navigator.pushNamed(
                                context,
                                AppRoutes.addressBook,
                              );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.red.shade400,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  locationProvider.area,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 20.w),
                                FaIcon(
                                  FontAwesomeIcons.caretDown,
                                  color: AppColor.primaryBlack,
                                  size: 15.sp,
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              locationProvider.fullAddress,
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      );
                },
              ),
            ),

            Consumer<OrderViewModel>(
              builder: (context, provider, child) {
                final active = provider.activeorderData;

                if (active.isEmpty) {
                  return SizedBox();
                }
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.activeOrders);
                  },
                  child:
                      userId.isEmpty
                          ? SizedBox()
                          : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 14.h,
                                      width: 14.w,
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
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Delivery",
                                      style: GoogleFonts.roboto(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "in 120 mins",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                );
              },
            ),
          ],
        ),
      ),

      backgroundColor: colorScheme.onPrimary,
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Consumer2<HomeViewmodel, ShopbycategoryViewmodel>(
                builder: (
                  context,
                  homeprovider,
                  shopbycategoryprovider,
                  child,
                ) {
                  final bestsellerdata = homeprovider.bestSellers;
                  final shopbycategorydata =
                      shopbycategoryprovider.shopbyCategoryData;
                  return Skeletonizer(
                    enabled:
                        homeprovider.isBestSellersLoading ||
                        shopbycategoryprovider.isShopByCategoryLoading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 265.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/homebanner.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        RewardsCard(),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'Bestsellers',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryBlack,
                              fontSize: 23.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'Most popular products near you!',
                            style: GoogleFonts.roboto(
                              color: AppColor.secondaryBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 350.h,
                          child: ListView.builder(
                            cacheExtent: 1000,
                            padding: EdgeInsets.zero,
                            itemCount: bestsellerdata.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = bestsellerdata[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? 20.w : 5.w,
                                  right:
                                      index == bestsellerdata.length - 1
                                          ? 20.w
                                          : 5.w,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.itemDetailsView,
                                      arguments: item.id,
                                    );
                                  },
                                  child: SizedBox(
                                    width: 260.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(13.r),
                                              child: CachedNetworkImage(
                                                imageUrl: item.img,
                                                height: 160.h,
                                                width: 250.w,
                                                fit: BoxFit.fill,
                                                placeholder:
                                                    (context, url) => Container(
                                                      height: 160.h,
                                                      width: 250.w,
                                                      color: Colors.grey[200],
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                            ),
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                          height: 160.h,
                                                          width: 250.w,
                                                          color:
                                                              Colors.grey[300],
                                                          child: Icon(
                                                            Icons.error,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -8.h,
                                              right: -8.w,
                                              child: CounterButton(
                                                itemId: item.id,
                                                initialCount: item.count,
                                                onChanged: (count) async {
                                                  await homeprovider
                                                      .fetchCartCount();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15.h),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 55.h,
                                                child: Text(
                                                  item.name,
                                                  style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20.sp,
                                                    color:
                                                        AppColor
                                                            .primaryBlackshade,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.weight,
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor
                                                              .secondaryBlack,
                                                    ),
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 2,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      ' | ${item.pieces} pieces | ${item.serves} Serves',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColor
                                                                .secondaryBlack,
                                                      ),
                                                      overflow:
                                                          TextOverflow.visible,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    "₹${item.discountPrice.toString()}",
                                                    style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.sp,
                                                      color:
                                                          AppColor
                                                              .primaryBlackshade,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    '₹${item.price}',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      decoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Text(
                                                    '${item.discount}% off',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5.h),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 15.h,
                                                    width: 15.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors
                                                              .orange
                                                              .shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor
                                                              .secondaryBlack,
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
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'Shop by category',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryBlack,
                              fontSize: 23.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'Fresh meats and much more!',
                            style: GoogleFonts.roboto(
                              color: AppColor.secondaryBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 5.w,
                                    mainAxisSpacing: 0.h,
                                    childAspectRatio: 0.6,
                                  ),
                              itemCount: shopbycategorydata.length,
                              itemBuilder: (context, index) {
                                final item = shopbycategorydata[index];
                                return _categories(
                                  image: item.img,
                                  label: item.name,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.shopbySubCategoryUrl,
                                      arguments: {
                                        'itemId': item.id,
                                        'itemName': item.name,
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 180.h),
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 20.h,
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
      ),
    );
  }

  Widget _categories({
    required String image,
    required String label,
    required VoidCallback onTap,
  }) {
    final colorscheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 140.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(6.r),
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                // boxShadow: [
                //   BoxShadow(
                //     color: AppColor.black.withOpacity(0.1),
                //     offset: Offset(0, 2),
                //     blurRadius: 7,
                //     spreadRadius: 1,
                //   ),
                // ],
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: colorscheme.primary,
                          strokeWidth: 2.w,
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
