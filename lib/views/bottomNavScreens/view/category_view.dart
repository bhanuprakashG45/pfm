import 'package:priya_fresh_meats/utils/exports.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final categoryprovider = Provider.of<CategoryProvider>(
        context,
        listen: false,
      );
      await categoryprovider.fetchCategoriesWithSubcategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'All Categories',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            color: AppColor.primaryBlack,
            fontSize: 24.sp,
          ),
        ),
        backgroundColor: colorScheme.onPrimary,
        surfaceTintColor: colorScheme.onPrimary,
        shadowColor: colorScheme.onPrimary,
        elevation: 0.01,
      ),
      backgroundColor: colorScheme.onPrimary,

      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.isLoadingSubcategories) {
            return const Center(child: CircularProgressIndicator());
          }

          if (categoryProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: Colors.red.shade300,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Oops! Something went wrong',
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      categoryProvider.errorMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: AppColor.secondaryBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          }
          if (categoryProvider.categoriesWithSubcategories.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 64.sp,
                    color: AppColor.dividergrey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No categories found',
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondaryBlack,
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 70.h),
            child: SafeArea(
              top: false,
              left: false,
              right: false,
              child: ListView.builder(
                cacheExtent: 1000,
                itemCount: categoryProvider.categoriesWithSubcategories.length,
                itemBuilder: (context, index) {
                  final category =
                      categoryProvider.categoriesWithSubcategories[index];
                  final isExpanded = categoryProvider.expandedIndex == index;

                  return Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                      bottom: 5.h,
                      right: 10.w,
                      top: 5.h,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            categoryProvider.setExpandedIndex(index);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 70.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child:
                                      category.img.isNotEmpty
                                          ? CachedNetworkImage(
                                            imageUrl: category.img,
                                            fit: BoxFit.cover,
                                            placeholder:
                                                (context, url) => Center(
                                                  child: SizedBox(
                                                    width: 20.w,
                                                    height: 20.h,
                                                    child:
                                                        const CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                  ),
                                                ),
                                            errorWidget:
                                                (
                                                  context,
                                                  url,
                                                  error,
                                                ) => Container(
                                                  color: Colors.grey.shade200,
                                                  child: Icon(
                                                    Icons.category,
                                                    color: Colors.grey.shade400,
                                                    size: 30.sp,
                                                  ),
                                                ),
                                          )
                                          : Container(
                                            color: Colors.grey.shade200,
                                            child: Icon(
                                              Icons.category,
                                              color: Colors.grey.shade400,
                                              size: 30.sp,
                                            ),
                                          ),
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category.name,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22.sp,
                                        color: AppColor.primaryBlack,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      category.typeCategories.isNotEmpty
                                          ? '${category.typeCategories.length} subcategories available'
                                          : 'Fresh and quality products',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.secondaryBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                size: 25.sp,
                                color: AppColor.secondaryBlack,
                              ),
                            ],
                          ),
                        ),
                        if (isExpanded && category.typeCategories.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(
                              top: 12.h,
                              left: 16.w,
                              right: 16.w,
                              bottom: 12.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 12.w,
                                        mainAxisSpacing: 14.h,
                                        childAspectRatio: 0.80,
                                      ),
                                  itemCount: category.typeCategories.length,
                                  itemBuilder: (context, subIndex) {
                                    final subcategory =
                                        category.typeCategories[subIndex];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => ItemsView(
                                                  categoryType:
                                                      subcategory.name,
                                                  subcategoryId: subcategory.id,
                                                ),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(6.r),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 55.h,
                                            width: 55.w,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: ClipOval(
                                              child:
                                                  subcategory.img.isNotEmpty
                                                      ? CachedNetworkImage(
                                                        imageUrl:
                                                            subcategory.img,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (
                                                              context,
                                                              url,
                                                            ) => Center(
                                                              child: SizedBox(
                                                                width: 15.w,
                                                                height: 15.h,
                                                                child:
                                                                    const CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          1.5,
                                                                    ),
                                                              ),
                                                            ),
                                                        errorWidget:
                                                            (
                                                              context,
                                                              url,
                                                              error,
                                                            ) => Container(
                                                              color:
                                                                  Colors
                                                                      .grey
                                                                      .shade200,
                                                              child: Icon(
                                                                Icons.fastfood,
                                                                color:
                                                                    Colors
                                                                        .grey
                                                                        .shade400,
                                                                size: 20.sp,
                                                              ),
                                                            ),
                                                      )
                                                      : Icon(
                                                        Icons.fastfood,
                                                        color: Colors.white,
                                                        size: 20.sp,
                                                      ),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),

                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 1.w,
                                              ),
                                              child: Text(
                                                subcategory.name,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.primaryBlack,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        else if (isExpanded && category.typeCategories.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'No subcategories available for ${category.name}',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  color: AppColor.secondaryBlack,
                                ),
                              ),
                            ),
                          ),

                        SizedBox(height: 10.h),
                        Divider(color: AppColor.white),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
