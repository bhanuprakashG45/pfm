import 'package:priya_fresh_meats/res/components/login_bottomsheet.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<String> _popularSearches = [
    'Fish',
    'Chicken',
    'Mutton',
    'Eggs',
    'Prawns',
  ];

  String? userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      _loadUserId();
      final searchscreenprovider = Provider.of<SearchViewmodel>(
        context,
        listen: false,
      );
      final homescreenprovider = Provider.of<HomeViewmodel>(
        context,
        listen: false,
      );

      await searchscreenprovider.fetchSearchShopByCategory();
      await searchscreenprovider.fetchAllSearchData();
      await homescreenprovider.fetchCartCount();
    });
  }

  void _loadUserId() async {
    final pref = SharedPref();
    final id = await pref.getUserId();

    setState(() {
      userId = id.isNotEmpty ? id : null;
      debugPrint('Loaded userId: $userId');
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        surfaceTintColor: colorScheme.onPrimary,
        toolbarHeight: 120.h,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            Text(
              'Search',
              style: GoogleFonts.roboto(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10.h),

            Consumer<SearchViewmodel>(
              builder: (context, provider, child) {
                return AnimatedSearchTextField(controller: searchController);
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
      backgroundColor: colorScheme.onPrimary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 200.h),
              child: Consumer2<SearchViewmodel, HomeViewmodel>(
                builder: (context, provider, homeProvider, _) {
                  final isSearching = provider.searchText.isNotEmpty;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      if (!isSearching) ...[
                        Text(
                          'Popular Searches',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryBlack,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 10.h,
                          children:
                              _popularSearches.map((searchLabel) {
                                return _PopularSearchChip(
                                  label: searchLabel,
                                  onTap: (value) {
                                    provider.updateSearchText(value);
                                    searchController.text = value;
                                    searchController
                                        .selection = TextSelection.fromPosition(
                                      TextPosition(offset: value.length),
                                    );
                                  },
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Shop by Categories',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryBlack,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        Builder(
                          builder: (context) {
                            final categories = provider.shopByCategoryData;
                            if (categories.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40.h),
                                  child: Text(
                                    'No categories found.',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              );
                            }

                            return Skeletonizer(
                              enabled: provider.isAllsearchDataLoading,
                              child: _buildCategoriesGrid(categories),
                            );
                          },
                        ),
                      ],

                      if (isSearching) ...[
                        Builder(
                          builder: (context) {
                            final results = provider.filteredSearchData;
                            homeProvider.notifiedItemIds.addAll(
                              results
                                  .where((item) => item.notify)
                                  .map((item) => item.id),
                            );

                            if (results.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40.h),
                                  child: Text(
                                    'No categories found.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                final item = results[index];

                                return _buildSearchItem(item);
                              },
                            );
                          },
                        ),
                      ],
                    ],
                  );
                },
              ),
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
    );
  }

  Widget _buildSearchItem(item) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 120.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.itemDetailsView,
                        arguments: item.id,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            item.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.secondaryBlack,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  item.weight,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '|',
                                style: GoogleFonts.roboto(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '₹${item.discountPrice}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              if (item.discount != 0) ...[
                                Text(
                                  '₹${item.price}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  '${item.discount}% off',
                                  style: GoogleFonts.roboto(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Container(
                                height: 14.h,
                                width: 14.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade300,
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.bolt,
                                  color: Colors.white,
                                  size: 10.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Delivery in 60 mins',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15).r,
                      child: Stack(
                        children: [
                          item.img.isEmpty
                              ? Container(
                                width: 120.w,
                                height: 80.h,
                                color: Colors.grey.shade300,
                                child: Icon(
                                  Icons.error,
                                  color: colorScheme.primary,
                                ),
                              )
                              : CachedNetworkImage(
                                imageUrl: item.img,
                                width: 120.w,
                                height: 80.h,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => Center(
                                      child: SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) => Container(
                                      width: 120.w,
                                      height: 80.h,
                                      color: Colors.grey.shade200,
                                      child: Icon(
                                        Icons.fastfood,
                                        color: Colors.grey.shade400,
                                        size: 30.sp,
                                      ),
                                    ),
                              ),

                          if (!item.available)
                            Container(
                              width: 120.w,
                              height: 80.h,
                              color: Colors.black.withValues(alpha: 0.4),
                            ),

                          if (!item.available)
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 24.h,
                                alignment: Alignment.center,
                                color: Colors.grey.withValues(alpha: 0.8),
                                child: Text(
                                  "Sold Out",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 60.h,
                      left: 10.w,
                      right: 10.w,
                      child: Consumer<HomeViewmodel>(
                        builder: (context, homeProvider, child) {
                          if (!item.available) {
                            return ElevatedButton(
                              onPressed: () async {
                                if (userId == null) {
                                  showLoginBottomSheet(
                                    context,
                                    message: "Please login for Access Notify.",
                                  );
                                  return;
                                } else {
                                  homeProvider.notifiedItemIds.contains(item.id)
                                      ? null
                                      : {
                                        await homeProvider.notifyMe(item.id),

                                        customSuccessToast(
                                          context,
                                          "Added to Notify List",
                                        ),
                                      };
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                              ),
                              child:
                                  homeProvider.isNotifyMeLoading
                                      ? SizedBox(
                                        height: 5.h,
                                        width: 5.w,
                                        child: CircularProgressIndicator(
                                          color: colorScheme.primary,
                                          strokeWidth: 1.w,
                                        ),
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            homeProvider.notifiedItemIds
                                                    .contains(item.id)
                                                ? "Notified"
                                                : "Notify",
                                            style: GoogleFonts.roboto(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  homeProvider.notifiedItemIds
                                                          .contains(item.id)
                                                      ? Colors.green
                                                      : colorScheme.primary,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Icon(
                                            homeProvider.notifiedItemIds
                                                    .contains(item.id)
                                                ? Icons.check_circle
                                                : Icons.notifications_active,
                                            color:
                                                homeProvider.notifiedItemIds
                                                        .contains(item.id)
                                                    ? Colors.green
                                                    : colorScheme.primary,
                                          ),
                                        ],
                                      ),
                            );
                          } else {
                            return AddToCartButton(
                              itemId: item.id,
                              initialCount: 0,
                              onChanged: (count) async {
                                if (userId == null) {
                                  showLoginBottomSheet(
                                    context,
                                    message:
                                        "Please login for Adding Items to Cart.",
                                  );
                                  return;
                                } else {
                                  await homeProvider.fetchCartCount();
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.h, bottom: 10.h),
            child: Divider(
              height: 1.h,
              color: Colors.grey.shade300,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        mainAxisSpacing: 0.h,
        crossAxisSpacing: 0.w,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.shopbySubCategoryUrl,
              arguments: {'itemId': category.id, 'itemName': category.name},
            );
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.dg),
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: CachedNetworkImage(
                    imageUrl: category.img,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.category,
                            color: Colors.grey.shade400,
                            size: 30.sp,
                          ),
                        ),
                  ),
                ),
              ),

              SizedBox(
                width: 77.w,
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PopularSearchChip extends StatelessWidget {
  final String label;
  final void Function(String) onTap;

  const _PopularSearchChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.secondaryBlack, width: 0.6),
          borderRadius: BorderRadius.circular(26).r,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.trending_up_outlined, color: Colors.grey.shade400),
            SizedBox(width: 10.w),
            Text(
              label,
              style: const TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
