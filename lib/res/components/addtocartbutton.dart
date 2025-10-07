import 'package:priya_fresh_meats/utils/exports.dart';

class AddToCartButton extends StatefulWidget {
  final Function(int count)? onChanged;
  final Color? backgroundColor;
  final Color? iconColor;
  final int initialCount;
  final String itemId;

  const AddToCartButton({
    Key? key,
    this.onChanged,
    this.backgroundColor,
    this.iconColor,
    this.initialCount = 0,
    required this.itemId,
  }) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  late ValueNotifier<int> countNotifier;
  late ValueNotifier<bool> isCounterVisibleNotifier;
  late ValueNotifier<bool> isDeletingNotifier;

  @override
  void initState() {
    super.initState();

    int initialCount = widget.initialCount < 0 ? 0 : widget.initialCount;
    countNotifier = ValueNotifier<int>(initialCount);
    isCounterVisibleNotifier = ValueNotifier<bool>(initialCount > 0);
    isDeletingNotifier = ValueNotifier<bool>(false);
  }

  void _increment() async {
    countNotifier.value++;
    widget.onChanged?.call(countNotifier.value);

    final homeVm = Provider.of<HomeViewmodel>(context, listen: false);
    await homeVm.updateCount(widget.itemId, countNotifier.value);
    await homeVm.fetchCartCount();
  }

  void _decrement() async {
    final homeVm = Provider.of<HomeViewmodel>(context, listen: false);

    if (countNotifier.value > 1) {
      countNotifier.value--;
      await homeVm.updateCount(widget.itemId, countNotifier.value);
    } else {
      isDeletingNotifier.value = true;
      await homeVm.deleteItem(widget.itemId);
      countNotifier.value = 0;
      isCounterVisibleNotifier.value = false;
      isDeletingNotifier.value = false;
    }

    await homeVm.fetchCartCount();
    widget.onChanged?.call(countNotifier.value);
  }

  void _addToCart() async {
    countNotifier.value = 1;
    isCounterVisibleNotifier.value = true;

    final homeVm = Provider.of<HomeViewmodel>(context, listen: false);
    await homeVm.addToCart(widget.itemId);
    await homeVm.fetchCartCount();

    widget.onChanged?.call(countNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = widget.iconColor ?? colorScheme.primary;

    return ValueListenableBuilder<bool>(
      valueListenable: isCounterVisibleNotifier,
      builder: (context, isVisible, child) {
        if (isVisible) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(8).r,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _decrement,
                  child: Icon(Icons.remove, size: 25.sp, color: iconColor),
                ),
                SizedBox(width: 10.w),
                ValueListenableBuilder<int>(
                  valueListenable: countNotifier,
                  builder:
                      (_, count, __) => Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: _increment,
                  child: Icon(Icons.add, size: 25.sp, color: iconColor),
                ),
              ],
            ),
          );
        } else {
          return ValueListenableBuilder<bool>(
            valueListenable: isDeletingNotifier,
            builder:
                (_, isDeleting, __) => InkWell(
                  onTap: isDeleting ? null : _addToCart,
                  child: Opacity(
                    opacity: isDeleting ? 0.5 : 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(5).r,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Add',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.add,
                            color: colorScheme.onPrimary,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          );
        }
      },
    );
  }
}
