import 'package:priya_fresh_meats/utils/exports.dart';

class CounterButton extends StatefulWidget {
  final Function(int count)? onChanged;
  final Color? backgroundColor;
  final Color? iconColor;
  final int initialCount;
  final String itemId;

  const CounterButton({
    super.key,
    this.onChanged,
    this.backgroundColor,
    this.iconColor,
    this.initialCount = 0,
    required this.itemId,
  });

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
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

  void _increment() {
    final homeVm = Provider.of<HomeViewmodel>(context, listen: false);

    countNotifier.value++;
    widget.onChanged?.call(countNotifier.value);
    homeVm.updateCount(widget.itemId, countNotifier.value);
  }

  void _decrement() {
    final homeVm = Provider.of<HomeViewmodel>(context, listen: false);

    if (countNotifier.value > 1) {
      countNotifier.value--;
      widget.onChanged?.call(countNotifier.value);

      homeVm.updateCount(widget.itemId, countNotifier.value);
    } else {
      isDeletingNotifier.value = true;
      countNotifier.value = 0;
      isCounterVisibleNotifier.value = false;
      widget.onChanged?.call(0);

      homeVm.deleteItem(widget.itemId).whenComplete(() {
        isDeletingNotifier.value = false;
      });
    }
  }

  void _addToCart() {
    final homeVm = Provider.of<HomeViewmodel>(context, listen: false);

    isCounterVisibleNotifier.value = true;
    countNotifier.value = 1;
    widget.onChanged?.call(1);

    homeVm.addToCart(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = widget.iconColor ?? colorScheme.primary;

    return ValueListenableBuilder<bool>(
      valueListenable: isCounterVisibleNotifier,
      builder: (context, isCounterVisible, _) {
        if (isCounterVisible) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(8).r,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _decrement,
                  child: Icon(Icons.remove, size: 20.sp, color: iconColor),
                ),
                SizedBox(width: 12.w),
                ValueListenableBuilder<int>(
                  valueListenable: countNotifier,
                  builder: (context, count, _) {
                    return Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: iconColor,
                      ),
                    );
                  },
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: _increment,
                  child: Icon(Icons.add, size: 20.sp, color: iconColor),
                ),
              ],
            ),
          );
        } else {
          return ValueListenableBuilder<bool>(
            valueListenable: isDeletingNotifier,
            builder: (context, isDeleting, _) {
              return GestureDetector(
                onTap: isDeleting ? null : _addToCart,
                child: Opacity(
                  opacity: isDeleting ? 0.5 : 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? Colors.white,
                      borderRadius: BorderRadius.circular(8).r,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Icon(Icons.add, size: 20.sp, color: iconColor),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    countNotifier.dispose();
    isCounterVisibleNotifier.dispose();
    isDeletingNotifier.dispose();
    super.dispose();
  }
}
